import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

/// Monitors network connectivity and exposes [isOnline] as a reactive bool.
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
      isOnline.value = _isConnected(results);
    });
  }

  bool _isConnected(List<ConnectivityResult> results) =>
      results.isNotEmpty &&
      results.any((r) => r != ConnectivityResult.none);
}

