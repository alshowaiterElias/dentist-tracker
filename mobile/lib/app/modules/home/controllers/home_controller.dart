import 'package:get/get.dart';

/// Controls the bottom navigation bar index.
class HomeController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
