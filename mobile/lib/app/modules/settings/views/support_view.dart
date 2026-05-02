import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';
import '../../../routes/app_routes.dart';

/// Support contact form — sends a message to the admin via Supabase.
class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> {
  final _formKey = GlobalKey<FormState>();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  final _isSubmitting = false.obs;

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('contact_support'.tr),
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
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.headset_mic_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'support_header'.tr,
                            style: AppTextStyles.headingSmall.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'support_subheader'.tr,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Subject
              AppTextField(
                controller: _subjectCtrl,
                label: 'support_subject'.tr,
                hint: 'support_subject_hint'.tr,
                prefixIcon: Icons.subject_rounded,
                validator: (v) => Validators.required(v, 'support_subject'.tr),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Message
              AppTextField(
                controller: _messageCtrl,
                label: 'support_message'.tr,
                hint: 'support_message_hint'.tr,
                prefixIcon: Icons.message_outlined,
                maxLines: 6,
                validator: (v) => Validators.required(v, 'support_message'.tr),
              ),
              const SizedBox(height: 12),

              Text(
                'support_note'.tr,
                style: AppTextStyles.caption.copyWith(
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                ),
              ),
              const SizedBox(height: 32),

              Obx(() => AppButton(
                    label: 'send_message'.tr,
                    isLoading: _isSubmitting.value,
                    icon: Icons.send_rounded,
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

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        Get.snackbar('error'.tr, 'something_went_wrong'.tr,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      await Supabase.instance.client.from('support_requests').insert({
        'user_id': user.id,
        'email': user.email ?? '',
        'subject': _subjectCtrl.text.trim(),
        'message': _messageCtrl.text.trim(),
        'status': 'open',
        'created_at': DateTime.now().toIso8601String(),
      });

      // Go back to settings, then show success dialog
      Get.back();
      _showSuccessDialog();
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isSubmitting.value = false;
    }
  }

  void _showSuccessDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'support_sent_title'.tr,
                style: AppTextStyles.headingMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'support_sent_desc'.tr,
                style: AppTextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'back_to_home'.tr,
                icon: Icons.home_rounded,
                onPressed: () {
                  Get.back(); // close dialog
                  Get.offAllNamed(AppRoutes.home);
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Get.back(), // close dialog, stay on settings
                child: Text('close'.tr),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
