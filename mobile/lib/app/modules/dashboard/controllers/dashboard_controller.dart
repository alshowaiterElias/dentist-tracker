import 'package:get/get.dart';
import '../../../data/models/daily_visit_model.dart';
import '../../../data/models/profile_model.dart';
import '../../../data/repositories/app_repository.dart';

class DashboardController extends GetxController {
  final _repo = AppRepository();

  final isLoading = true.obs;
  final profile = Rxn<ProfileModel>();
  final selectedDayIndex = 0.obs;
  final dailyVisits = <DailyVisitModel>[].obs;

  /// 8 dates: today + 7 upcoming days.
  late final List<DateTime> weekDates;

  // ─── Daily totals (computed) ──────────────────────────────────────

  double get dayTotalCost =>
      dailyVisits.fold(0, (sum, v) => sum + v.totalCost);
  double get dayTotalPaid =>
      dailyVisits.fold(0, (sum, v) => sum + v.amountPaid);
  double get dayTotalRemaining => dayTotalCost - dayTotalPaid;

  @override
  void onInit() {
    super.onInit();
    final today = DateTime.now();
    weekDates = List.generate(
      8,
      (i) => DateTime(today.year, today.month, today.day + i),
    );
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;
      profile.value = await _repo.getProfile();
      await loadDay(selectedDayIndex.value);
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadDay(int index) async {
    selectedDayIndex.value = index;
    try {
      final visits = await _repo.getDailyVisits(weekDates[index]);
      dailyVisits.value = visits;
    } catch (_) {
      dailyVisits.clear();
    }
  }

  Future<void> toggleAttendance(String appointmentId) async {
    final idx = dailyVisits.indexWhere((v) => v.appointmentId == appointmentId);
    if (idx < 0) return;

    final current = dailyVisits[idx];
    final newStatus =
        current.appointmentStatus == 'completed' ? 'no_show' : 'completed';

    await _repo.updateAppointmentStatus(appointmentId, newStatus);

    // Optimistic update — rebuild the list item in place
    dailyVisits[idx] = DailyVisitModel(
      appointmentId: current.appointmentId,
      patientId: current.patientId,
      patientName: current.patientName,
      treatmentId: current.treatmentId,
      procedureType: current.procedureType,
      totalCost: current.totalCost,
      amountPaid: current.amountPaid,
      nextAppointment: current.nextAppointment,
      appointmentStatus: newStatus,
      notes: current.notes,
    );
  }

  Future<void> refreshDashboard() async {
    await loadDay(selectedDayIndex.value);
  }
}
