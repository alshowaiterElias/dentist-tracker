import 'package:get/get.dart';
import '../controllers/patient_list_controller.dart';

class PatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientListController>(() => PatientListController());
  }
}
