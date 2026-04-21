import 'package:get/get.dart';
import '../../../data/models/patient_model.dart';
import '../../../data/models/treatment_model.dart';
import '../../../data/models/payment_model.dart';
import '../../../data/models/appointment_model.dart';
import '../../../data/models/medication_model.dart';
import '../../../data/models/file_model.dart';
import '../../../data/repositories/app_repository.dart';

class PatientDetailController extends GetxController {
  final _repo = AppRepository();

  final isLoading = true.obs;
  final patient = Rxn<PatientModel>();
  final financials = <String, dynamic>{}.obs;
  final treatments = <TreatmentModel>[].obs;
  final payments = <PaymentModel>[].obs;
  final appointments = <AppointmentModel>[].obs;
  final medications = <MedicationModel>[].obs;
  final files = <FileModel>[].obs;

  String? patientId;

  // Derived financial values
  double get totalCost => (financials['total_cost'] as num?)?.toDouble() ?? 0;
  double get totalPaid => (financials['total_paid'] as num?)?.toDouble() ?? 0;
  double get remainingBalance =>
      (financials['remaining_balance'] as num?)?.toDouble() ?? 0;
  DateTime? get nextAppointment {
    final val = financials['next_appointment'];
    if (val == null) return null;
    return DateTime.tryParse(val.toString());
  }

  @override
  void onInit() {
    super.onInit();
    patientId = Get.arguments as String?;
    if (patientId != null) {
      loadPatientData();
    }
  }

  Future<void> loadPatientData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        _repo.getPatient(patientId!),
        _repo.getPatientFinancials(patientId!),
        _repo.getTreatments(patientId: patientId),
        _repo.getAppointments(patientId: patientId),
        _repo.getMedications(patientId: patientId),
        _repo.getFiles(patientId: patientId),
      ]);

      patient.value = results[0] as PatientModel?;
      financials.value = results[1] as Map<String, dynamic>;
      treatments.value = results[2] as List<TreatmentModel>;
      appointments.value = results[3] as List<AppointmentModel>;
      medications.value = results[4] as List<MedicationModel>;
      files.value = results[5] as List<FileModel>;

      // Collect payments from all treatments
      final allPayments = <PaymentModel>[];
      for (final t in treatments) {
        final tPayments = await _repo.getPayments(treatmentId: t.id);
        allPayments.addAll(tPayments);
      }
      payments.value = allPayments;
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async => loadPatientData();
}
