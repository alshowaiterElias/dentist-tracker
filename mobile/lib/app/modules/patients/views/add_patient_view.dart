import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';
import '../controllers/patient_list_controller.dart';

/// Add / Edit patient form.
class AddPatientView extends GetView<PatientListController> {
  const AddPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final ageCtrl = TextEditingController();
    final medicalStatusCtrl = TextEditingController();
    final conditionCtrl = TextEditingController();
    final notesCtrl = TextEditingController();
    final isSubmitting = false.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text('add_patient'.tr),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              _buildSectionTag('patient_info'.tr, isDark),
              const SizedBox(height: 20),

              // Full Name
              AppTextField(
                controller: nameCtrl,
                label: 'full_name'.tr,
                hint: 'full_name'.tr,
                prefixIcon: Icons.person_outline,
                validator: Validators.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Phone
              AppTextField(
                controller: phoneCtrl,
                label: 'phone'.tr,
                hint: '+967 ...',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: Validators.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Age
              AppTextField(
                controller: ageCtrl,
                label: 'age'.tr,
                hint: 'age'.tr,
                prefixIcon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                validator: Validators.age,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),

              // Medical section
              _buildSectionTag('medical_status'.tr, isDark),
              const SizedBox(height: 20),

              AppTextField(
                controller: medicalStatusCtrl,
                label: 'medical_status'.tr,
                hint: 'e.g., Healthy, Diabetic, Hypertension',
                prefixIcon: Icons.monitor_heart_outlined,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: conditionCtrl,
                label: 'initial_condition'.tr,
                hint: 'Describe the patient\'s dental condition...',
                prefixIcon: Icons.medical_information_outlined,
                maxLines: 3,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: notesCtrl,
                label: '${'notes'.tr} (${'optional'.tr})',
                hint: 'Any additional notes...',
                prefixIcon: Icons.note_outlined,
                maxLines: 3,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),

              // Submit
              Obx(() => AppButton(
                    label: 'save'.tr,
                    isLoading: isSubmitting.value,
                    icon: Icons.check_rounded,
                    onPressed: () async {
                      if (!(formKey.currentState?.validate() ?? false)) return;
                      isSubmitting.value = true;
                      await controller.addPatient(
                        fullName: nameCtrl.text.trim(),
                        phone: phoneCtrl.text.trim(),
                        age: int.tryParse(ageCtrl.text.trim()),
                        medicalStatus: medicalStatusCtrl.text.trim().isEmpty
                            ? null
                            : medicalStatusCtrl.text.trim(),
                        condition: conditionCtrl.text.trim().isEmpty
                            ? null
                            : conditionCtrl.text.trim(),
                        notes: notesCtrl.text.trim().isEmpty
                            ? null
                            : notesCtrl.text.trim(),
                      );
                      isSubmitting.value = false;
                    },
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
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
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
