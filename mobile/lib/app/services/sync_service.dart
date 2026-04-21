import 'dart:convert';
import 'package:dentist_tracker/app/data/local/local_database.dart';
import 'package:dentist_tracker/app/data/providers/supabase_provider.dart';
import 'package:get/get.dart';

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
  }

  Future<void> _refreshPendingCount() async {
    pendingCount.value = await _db.getPendingCount();
  }

  /// Call this when coming back online to replay all queued operations.
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
          await SupabaseProvider.from(
            op.targetTable,
          ).upsert(payload, onConflict: 'id');
          break;
        case 'update':
          final id = payload['id'] as String;
          final updates = Map<String, dynamic>.from(payload)..remove('id');
          await SupabaseProvider.from(
            op.targetTable,
          ).update(updates).eq('id', id);
          break;
        case 'delete':
          final id = payload['id'] as String;
          await SupabaseProvider.from(op.targetTable).delete().eq('id', id);
          break;
        case 'delete_appointment':
          final id = payload['id'] as String;
          await SupabaseProvider.from('appointments').delete().eq('id', id);
          break;
        case 'delete_medication':
          final id = payload['id'] as String;
          await SupabaseProvider.from('medications').delete().eq('id', id);
          break;
        case 'soft_delete_patient':
          final id = payload['id'] as String;
          await SupabaseProvider.from(
            'patients',
          ).update({'is_deleted': true}).eq('id', id);
          break;
      }

      // Success → remove from queue
      await _db.deleteQueueOp(op.id);
    } catch (e) {
      // Mark as failed (increment retry count)
      await _db.markQueueOpFailed(op.id, e.toString());
    }
  }

  /// Enqueue a pending operation and refresh the count badge.
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
