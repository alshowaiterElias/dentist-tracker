import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';
import '../../../data/models/patient_model.dart';
import '../../../data/repositories/app_repository.dart';
import '../controllers/patient_detail_controller.dart';

/// Edit patient form with prefilled fields.
class EditPatientView extends StatefulWidget {
  const EditPatientView({super.key});

  @override
  State<EditPatientView> createState() => _EditPatientViewState();
}

class _EditPatientViewState extends State<EditPatientView> {
  final _formKey = GlobalKey<FormState>();
  final _repo = AppRepository();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _ageCtrl;
  late final TextEditingController _medicalStatusCtrl;
  late final TextEditingController _conditionCtrl;
  late final TextEditingController _notesCtrl;

  final _isSubmitting = false.obs;
  late final PatientModel _patient;

  @override
  void initState() {
    super.initState();
    _patient = Get.arguments as PatientModel;

    _nameCtrl = TextEditingController(text: _patient.fullName);
    _phoneCtrl = TextEditingController(text: _patient.phone);
    _ageCtrl = TextEditingController(
      text: _patient.age != null ? _patient.age.toString() : '',
    );
    _medicalStatusCtrl = TextEditingController(text: _patient.medicalStatus ?? '');
    _conditionCtrl = TextEditingController(text: _patient.condition ?? '');
    _notesCtrl = TextEditingController(text: _patient.notes ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _ageCtrl.dispose();
    _medicalStatusCtrl.dispose();
    _conditionCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('edit_patient'.tr),
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
              _buildSectionTag('patient_info'.tr, isDark),
              const SizedBox(height: 20),

              AppTextField(
                controller: _nameCtrl,
                label: 'full_name'.tr,
                hint: 'full_name'.tr,
                prefixIcon: Icons.person_outline,
                validator: Validators.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _phoneCtrl,
                label: 'phone'.tr,
                hint: '+967 ...',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: Validators.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _ageCtrl,
                label: 'age'.tr,
                hint: 'age'.tr,
                prefixIcon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                validator: Validators.age,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),

              _buildSectionTag('medical_status'.tr, isDark),
              const SizedBox(height: 20),

              AppTextField(
                controller: _medicalStatusCtrl,
                label: 'medical_status'.tr,
                hint: 'e.g., Healthy, Diabetic, Hypertension',
                prefixIcon: Icons.monitor_heart_outlined,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _conditionCtrl,
                label: 'initial_condition'.tr,
                hint: 'Describe the patient\'s dental condition...',
                prefixIcon: Icons.medical_information_outlined,
                maxLines: 3,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _notesCtrl,
                label: '${'notes'.tr} (${'optional'.tr})',
                hint: 'Any additional notes...',
                prefixIcon: Icons.note_outlined,
                maxLines: 3,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),

              Obx(() => AppButton(
                    label: 'save_changes'.tr,
                    isLoading: _isSubmitting.value,
                    icon: Icons.check_rounded,
                    onPressed: _submit,
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    try {
      _isSubmitting.value = true;

      final updates = <String, dynamic>{
        'full_name': _nameCtrl.text.trim(),
        'phone': _phoneCtrl.text.trim(),
        'age': int.tryParse(_ageCtrl.text.trim()),
        'medical_status': _medicalStatusCtrl.text.trim().isEmpty
            ? null
            : _medicalStatusCtrl.text.trim(),
        'condition': _conditionCtrl.text.trim().isEmpty
            ? null
            : _conditionCtrl.text.trim(),
        'notes': _notesCtrl.text.trim().isEmpty
            ? null
            : _notesCtrl.text.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      await _repo.updatePatient(_patient.id, updates);

      Get.back();
      Get.snackbar('success'.tr, 'patient_updated'.tr,
          snackPosition: SnackPosition.BOTTOM);

      // Refresh patient detail if the controller is alive
      if (Get.isRegistered<PatientDetailController>()) {
        Get.find<PatientDetailController>().loadPatientData();
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isSubmitting.value = false;
    }
  }

  Widget _buildSectionTag(String label, bool isDark) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: isDark ? AppColors.primaryLight : AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label.toUpperCase(),
          style: AppTextStyles.overline.copyWith(
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
