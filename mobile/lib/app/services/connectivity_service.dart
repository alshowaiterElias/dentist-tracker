import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

/// Monitors network connectivity and exposes [isOnline] as a reactive bool.
/// Triggers SyncService when coming back online.
class ConnectivityService extends GetxService {
  static ConnectivityService get to => Get.find();

  final isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    // Check current state immediately
    final result = await Connectivity().checkConnectivity();
    isOnline.value = _isConnected(result);

    // Listen to changes
    Connectivity().onConnectivityChanged.listen((results) {
      final connected = _isConnected(results);
      final wasOffline = !isOnline.value;
      isOnline.value = connected;

      // Coming back online → flush sync queue
      if (wasOffline && connected) {
        _flushSyncQueue();
      }
    });
  }

  bool _isConnected(List<ConnectivityResult> results) =>
      results.isNotEmpty &&
      results.any((r) => r != ConnectivityResult.none);

  void _flushSyncQueue() {
    // Import lazily to avoid circular dependency
    if (Get.isRegistered<dynamic>(tag: 'sync_service')) {
      // SyncService will self-register under tag
    }
    // Trigger via Get.find after SyncService is registered in main
    try {
      final dynamic syncService = Get.find(tag: 'sync_service');
      syncService.processQueue();
    } catch (_) {
      // SyncService not yet registered — ok, it will process on next check
    }
  }
}
