import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/patient_model.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../data/providers/supabase_provider.dart';
import '../../../routes/app_routes.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class PatientListController extends GetxController {
  final _repo = AppRepository();

  final isLoading = true.obs;
  final patients = <PatientModel>[].obs;
  final searchQuery = ''.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadPatients();

    // Debounced search
    debounce(searchQuery, (_) => loadPatients(),
        time: const Duration(milliseconds: 400));
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadPatients() async {
    try {
      isLoading.value = true;
      final result = await _repo.getPatients(
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
      );
      patients.value = result;
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  Future<void> addPatient({
    required String fullName,
    required String phone,
    int? age,
    String? medicalStatus,
    String? condition,
    String? notes,
  }) async {
    try {
      final userId = SupabaseProvider.userId;
      if (userId == null) return;

      final newPatient = await _repo.createPatient({
        'dentist_id': userId,
        'full_name': fullName,
        'phone': phone,
        'age': age,
        'medical_status': medicalStatus,
        'condition': condition,
        'notes': notes,
      });

      Get.snackbar('success'.tr, 'patient_added'.tr,
          snackPosition: SnackPosition.BOTTOM);

      // Refresh patient list
      await loadPatients();

      // Refresh dashboard counts
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().refreshDashboard();
      }

      // Navigate to the new patient's detail page (replace the add form)
      Get.back(); // close add patient form
      Get.toNamed(AppRoutes.patientDetail, arguments: newPatient.id);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('idx_patients_phone_dentist') || msg.contains('duplicate')) {
        Get.snackbar('error'.tr, 'A patient with this phone number already exists.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('error'.tr, 'something_went_wrong'.tr,
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> updatePatient(
      String id, Map<String, dynamic> updates) async {
    try {
      await _repo.updatePatient(id, updates);
      Get.snackbar('success'.tr, 'patient_updated'.tr,
          snackPosition: SnackPosition.BOTTOM);
      await loadPatients();
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deletePatient(String id) async {
    try {
      await _repo.softDeletePatient(id);
      await loadPatients();
      // Refresh dashboard after deletion
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().refreshDashboard();
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
