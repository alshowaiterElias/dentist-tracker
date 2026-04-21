import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../data/local/local_database.dart';
import '../data/providers/supabase_provider.dart';
import 'connectivity_service.dart';

/// Processes the offline sync queue, replaying pending operations
/// to Supabase when the device is back online.
class SyncService extends GetxService {
  static SyncService get to => Get.find(tag: 'sync_service');

  final LocalDatabase _db;
  final pendingCount = 0.obs;
  final isSyncing = false.obs;

  SyncService(this._db);

  @override
  void onInit() {
    super.onInit();
    _refreshPendingCount();

    // Auto-trigger when connectivity is restored
    ever(ConnectivityService.to.isOnline, (bool online) {
      if (online) processQueue();
    });
  }

  Future<void> _refreshPendingCount() async {
    pendingCount.value = await _db.getPendingCount();
  }

  /// Replay all queued operations against Supabase.
  Future<void> processQueue() async {
    if (isSyncing.value) return;
    if (!ConnectivityService.to.isOnline.value) return;

    isSyncing.value = true;
    try {
      final ops = await _db.getPendingOps();
      for (final op in ops) {
        await _processOp(op);
      }
    } finally {
      isSyncing.value = false;
      await _refreshPendingCount();
    }
  }

  Future<void> _processOp(SyncQueueTableData op) async {
    try {
      final payload = jsonDecode(op.payload) as Map<String, dynamic>;

      switch (op.action) {
        case 'insert':
          await SupabaseProvider.from(op.targetTable)
              .upsert(payload, onConflict: 'id');
          break;

        case 'update':
          final id = payload['id'] as String;
          final updates = Map<String, dynamic>.from(payload)..remove('id');
          await SupabaseProvider.from(op.targetTable)
              .update(updates)
              .eq('id', id);
          break;

        case 'delete':
          final id = payload['id'] as String;
          await SupabaseProvider.from(op.targetTable).delete().eq('id', id);
          break;

        case 'delete_appointment':
          await SupabaseProvider.from('appointments')
              .delete()
              .eq('id', payload['id'] as String);
          break;

        case 'delete_medication':
          await SupabaseProvider.from('medications')
              .delete()
              .eq('id', payload['id'] as String);
          break;

        case 'soft_delete_patient':
          await SupabaseProvider.from('patients')
              .update({'is_deleted': true})
              .eq('id', payload['id'] as String);
          break;

        case 'upload_file':
          await _processFileUpload(payload);
          break;
      }

      // Success — remove from queue
      await _db.deleteQueueOp(op.id);
    } catch (e) {
      // Increment retry count — item stays in queue for next attempt
      await _db.incrementRetryCount(op.id, e.toString());
    }
  }

  Future<void> _processFileUpload(Map<String, dynamic> payload) async {
    final localPath = payload['local_path'] as String;
    final storagePath = payload['storage_path'] as String;
    final fileId = payload['id'] as String;

    // Upload binary to Supabase Storage
    final file = File(localPath);
    if (!await file.exists()) {
      throw Exception('Local file no longer exists: $localPath');
    }
    await SupabaseProvider.storage.upload(storagePath, file);
    final fileUrl = SupabaseProvider.storage.getPublicUrl(storagePath);

    // Build the DB record (strip local_path from payload)
    final dbPayload = Map<String, dynamic>.from(payload)
      ..remove('local_path')
      ..['file_url'] = fileUrl;

    // Upsert into Supabase DB
    await SupabaseProvider.from('files').upsert(dbPayload, onConflict: 'id');

    // Update our local SQLite record with the real URL
    await _db.updateFileUrl(fileId, fileUrl);

    // Clean up the local pending copy
    try {
      await file.delete();
    } catch (_) {}
  }

  /// Enqueue a generic data operation and refresh count badge.
  Future<void> enqueue({
    required String recordUuid,
    required String tableName,
    required String action,
    required Map<String, dynamic> payload,
  }) async {
    await _db.enqueueOp(
      recordUuid: recordUuid,
      tableName: tableName,
      action: action,
      payload: payload,
    );
    await _refreshPendingCount();
  }
}
