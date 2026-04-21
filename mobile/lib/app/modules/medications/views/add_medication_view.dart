import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/providers/supabase_provider.dart';
import '../../../data/repositories/app_repository.dart';
import '../../patients/controllers/patient_detail_controller.dart';

/// Add medication / prescription form.
class AddMedicationView extends StatefulWidget {
  const AddMedicationView({super.key});

  @override
  State<AddMedicationView> createState() => _AddMedicationViewState();
}

class _AddMedicationViewState extends State<AddMedicationView> {
  final _formKey = GlobalKey<FormState>();
  final _repo = AppRepository();

  final _nameCtrl = TextEditingController();
  final _dosageCtrl = TextEditingController();
  final _frequencyCtrl = TextEditingController();
  final _durationCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _isSubmitting = false.obs;
  DateTime _prescribedDate = DateTime.now();

  String? _patientId;
  String? _treatmentId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      _patientId = args['patientId'] as String?;
      _treatmentId = args['treatmentId'] as String?;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _dosageCtrl.dispose();
    _frequencyCtrl.dispose();
    _durationCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('prescribe_medication'.tr),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: _nameCtrl,
                label: 'medication_name'.tr,
                hint: 'e.g., Amoxicillin, Ibuprofen',
                prefixIcon: Icons.medication_outlined,
                validator: Validators.medicationName,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _dosageCtrl,
                      label: 'dosage'.tr,
                      hint: 'dosage_hint'.tr,
                      prefixIcon: Icons.scale_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                      controller: _frequencyCtrl,
                      label: 'frequency'.tr,
                      hint: 'frequency_hint'.tr,
                      prefixIcon: Icons.schedule_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _durationCtrl,
                label: 'duration'.tr,
                hint: 'duration_hint'.tr,
                prefixIcon: Icons.timer_outlined,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'prescribed_date'.tr,
                readOnly: true,
                controller: TextEditingController(
                  text: Formatters.dateShortEn(_prescribedDate),
                ),
                prefixIcon: Icons.calendar_today_outlined,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _prescribedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (picked != null) {
                    setState(() => _prescribedDate = picked);
                  }
                },
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _notesCtrl,
                label: '${'notes'.tr} (${'optional'.tr})',
                hint: 'e.g., Take after meals',
                maxLines: 3,
                prefixIcon: Icons.note_outlined,
              ),
              const SizedBox(height: 32),

              Obx(
                () => AppButton(
                  label: 'save'.tr,
                  isLoading: _isSubmitting.value,
                  icon: Icons.check_rounded,
                  onPressed: _submit,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_patientId == null) return;

    try {
      _isSubmitting.value = true;
      await _repo.createMedication({
        'patient_id': _patientId,
        'treatment_id': _treatmentId,
        'dentist_id': SupabaseProvider.userId,
        'medication_name': _nameCtrl.text.trim(),
        'dosage': _dosageCtrl.text.trim().isEmpty
            ? null
            : _dosageCtrl.text.trim(),
        'frequency': _frequencyCtrl.text.trim().isEmpty
            ? null
            : _frequencyCtrl.text.trim(),
        'duration': _durationCtrl.text.trim().isEmpty
            ? null
            : _durationCtrl.text.trim(),
        'notes': _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
        'prescribed_date': Formatters.dateIso(_prescribedDate),
      });

      // Navigate back first — works whether online or offline
      Get.back();
      Get.snackbar(
        'success'.tr,
        'medication_prescribed'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Refresh patient detail in background
      if (Get.isRegistered<PatientDetailController>()) {
        Get.find<PatientDetailController>().loadPatientData();
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'something_went_wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isSubmitting.value = false;
    }
  }
}
