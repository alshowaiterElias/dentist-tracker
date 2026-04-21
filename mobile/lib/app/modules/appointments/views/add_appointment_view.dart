import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/patient_model.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../data/providers/supabase_provider.dart';
import '../../patients/controllers/patient_detail_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

/// Add appointment form with patient search.
class AddAppointmentView extends StatefulWidget {
  const AddAppointmentView({super.key});

  @override
  State<AddAppointmentView> createState() => _AddAppointmentViewState();
}

class _AddAppointmentViewState extends State<AddAppointmentView> {
  final _repo = AppRepository();
  final _notesCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  final _isSubmitting = false.obs;

  DateTime _selectedDate = DateTime.now();
  PatientModel? _selectedPatient;
  List<PatientModel> _patients = [];
  List<PatientModel> _filteredPatients = [];
  bool _showPatientPicker = false;

  @override
  void initState() {
    super.initState();
    _loadPatients();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final patientId = args['patientId'] as String?;
      if (patientId != null) {
        _loadPatient(patientId);
      }
      if (args['date'] != null) {
        _selectedDate = args['date'] as DateTime;
      }
    }
  }

  Future<void> _loadPatients() async {
    _patients = await _repo.getPatients();
    _filteredPatients = _patients;
    if (mounted) setState(() {});
  }

  Future<void> _loadPatient(String id) async {
    final patient = await _repo.getPatient(id);
    if (patient != null) {
      setState(() => _selectedPatient = patient);
    }
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('new_appointment'.tr),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Patient Selection ─────────────────────────
            Text('select_patient'.tr, style: AppTextStyles.labelMedium.copyWith(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            )),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => setState(() => _showPatientPicker = !_showPatientPicker),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardElevated : AppColors.lightCardElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person_outline, size: 20,
                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedPatient?.fullName ?? 'select_patient'.tr,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: _selectedPatient != null
                              ? (isDark ? AppColors.darkText : AppColors.lightText)
                              : (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
                        ),
                      ),
                    ),
                    Icon(
                      _showPatientPicker ? Icons.expand_less : Icons.expand_more,
                      color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                    ),
                  ],
                ),
              ),
            ),
            if (_showPatientPicker) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _searchCtrl,
                onChanged: (v) {
                  setState(() {
                    _filteredPatients = _patients.where((p) =>
                        p.fullName.toLowerCase().contains(v.toLowerCase()) ||
                        p.phone.contains(v)).toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'search_patients'.tr,
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  filled: true,
                  fillColor: isDark ? AppColors.darkCardElevated : AppColors.lightCardElevated,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredPatients.length,
                  itemBuilder: (context, i) {
                    final p = _filteredPatients[i];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                        child: Text(p.fullName[0].toUpperCase(),
                            style: const TextStyle(color: AppColors.primary, fontSize: 12)),
                      ),
                      title: Text(p.fullName, style: AppTextStyles.labelMedium),
                      subtitle: Text(p.phone, style: AppTextStyles.caption),
                      onTap: () {
                        setState(() {
                          _selectedPatient = p;
                          _showPatientPicker = false;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 20),

            // ─── Date ──────────────────────────────────────
            AppTextField(
              label: 'appointment_date'.tr,
              readOnly: true,
              controller: TextEditingController(text: Formatters.dateShortEn(_selectedDate)),
              prefixIcon: Icons.calendar_today_outlined,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() => _selectedDate = picked);
                }
              },
            ),
            const SizedBox(height: 16),

            // ─── Notes ─────────────────────────────────────
            AppTextField(
              controller: _notesCtrl,
              label: '${'appointment_notes'.tr} (${'optional'.tr})',
              hint: 'notes'.tr,
              maxLines: 3,
              prefixIcon: Icons.note_outlined,
            ),
            const SizedBox(height: 32),

            Obx(() => AppButton(
              label: 'save'.tr,
              isLoading: _isSubmitting.value,
              icon: Icons.check_rounded,
              onPressed: _submit,
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_selectedPatient == null) {
      Get.snackbar('error'.tr, 'select_patient'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      _isSubmitting.value = true;
      await _repo.createAppointment({
        'patient_id': _selectedPatient!.id,
        'dentist_id': SupabaseProvider.userId,
        'appointment_date': Formatters.dateIso(_selectedDate),
        'notes': _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      });

      Get.snackbar('success'.tr, 'appointment_created'.tr,
          snackPosition: SnackPosition.BOTTOM);

      // Navigate back FIRST so it always works
      Get.back();

      // Refresh controllers in background
      if (Get.isRegistered<PatientDetailController>()) {
        Get.find<PatientDetailController>().loadPatientData();
      }
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().refreshDashboard();
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isSubmitting.value = false;
    }
  }
}
