import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../dashboard/bindings/dashboard_binding.dart';
import '../../patients/bindings/patient_binding.dart';
import '../../appointments/bindings/appointment_binding.dart';
import '../../reports/bindings/report_binding.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    DashboardBinding().dependencies();
    PatientBinding().dependencies();
    AppointmentBinding().dependencies();
    ReportBinding().dependencies();
  }
}
