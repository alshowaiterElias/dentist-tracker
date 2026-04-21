import 'package:get/get.dart';
import '../../../data/models/appointment_model.dart';
import '../../../data/models/profile_model.dart';
import '../../../data/repositories/app_repository.dart';

class DashboardController extends GetxController {
  final _repo = AppRepository();

  final isLoading = true.obs;
  final profile = Rxn<ProfileModel>();
  final todayAppointments = <AppointmentModel>[].obs;
  final financialSummary = <String, dynamic>{}.obs;

  // Derived getters
  double get totalIncome =>
      (financialSummary['total_income'] as num?)?.toDouble() ?? 0;
  double get totalPaid =>
      (financialSummary['total_paid'] as num?)?.toDouble() ?? 0;
  double get totalUnpaid => totalIncome - totalPaid;
  double get technicianCosts =>
      (financialSummary['total_technician_cost'] as num?)?.toDouble() ?? 0;
  double get dentistEarnings {
    final pct = profile.value?.revenuePercentage ?? 100;
    return (totalIncome - technicianCosts) * (pct / 100);
  }

  int get totalPatients =>
      (financialSummary['total_patients'] as num?)?.toInt() ?? 0;
  int get totalTreatments =>
      (financialSummary['total_treatments'] as num?)?.toInt() ?? 0;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;

      // Load everything in parallel
      final results = await Future.wait([
        _repo.getProfile(),
        _repo.getAppointments(date: DateTime.now()),
        _repo.getFinancialSummary(),
      ]);

      profile.value = results[0] as ProfileModel?;
      todayAppointments.value = results[1] as List<AppointmentModel>;
      financialSummary.value = results[2] as Map<String, dynamic>;
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboard();
  }
}
