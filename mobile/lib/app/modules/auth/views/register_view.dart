import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';

/// Register screen matching the login aesthetic.
class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.authGradient),
        child: SafeArea(
          child: Column(
            children: [
              // ─── Back Button ─────────────────────────────
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                ),
              ),

              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: controller.registerFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ─── Header ────────────────────────────
                          Text(
                            'register'.tr,
                            style: AppTextStyles.displaySmall.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'register_subtitle'.tr,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // ─── Form Card ─────────────────────────
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Obx(() {
                              final isEmail = controller.authMode.value == 'email';
                              final isOtpSent = controller.isOtpSent.value;

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Name field
                                  AppTextField(
                                    controller: controller.nameController,
                                    hint: 'full_name'.tr,
                                    prefixIcon: Icons.person_outline,
                                    validator: Validators.name,
                                  ),
                                  const SizedBox(height: 16),

                                  // Mode toggle
                                  _buildModeToggle(isEmail),
                                  const SizedBox(height: 16),

                                  // Email or Phone field
                                  if (isEmail) ...[
                                    AppTextField(
                                      controller: controller.emailController,
                                      hint: 'email'.tr,
                                      prefixIcon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: Validators.email,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller: controller.passwordController,
                                      hint: 'password'.tr,
                                      prefixIcon: Icons.lock_outlined,
                                      obscureText: true,
                                      validator: Validators.password,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ] else ...[
                                    AppTextField(
                                      controller: controller.phoneController,
                                      hint: 'phone'.tr,
                                      prefixIcon: Icons.phone_outlined,
                                      keyboardType: TextInputType.phone,
                                      validator: Validators.phone,
                                    ),
                                    if (isOtpSent) ...[
                                      const SizedBox(height: 16),
                                      AppTextField(
                                        controller: controller.otpController,
                                        hint: 'enter_otp'.tr,
                                        prefixIcon: Icons.lock_outline,
                                        keyboardType: TextInputType.number,
                                        maxLength: 6,
                                      ),
                                    ],
                                  ],

                                  const SizedBox(height: 24),

                                  // Submit button
                                  if (isEmail)
                                    AppButton(
                                      label: 'register'.tr,
                                      isLoading: controller.isLoading.value,
                                      icon: Icons.person_add_rounded,
                                      onPressed: controller.registerWithEmail,
                                    )
                                  else
                                    AppButton(
                                      label: isOtpSent
                                          ? 'verify_otp'.tr
                                          : 'send_otp'.tr,
                                      isLoading: controller.isLoading.value,
                                      icon: isOtpSent
                                          ? Icons.verified_outlined
                                          : Icons.sms_outlined,
                                      onPressed: isOtpSent
                                          ? controller.verifyPhoneOtp
                                          : controller.registerWithPhone,
                                    ),
                                ],
                              );
                            }),
                          ),

                          const SizedBox(height: 24),

                          // ─── Login Link ────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'have_account'.tr,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  'login'.tr,
                                  style: AppTextStyles.labelLarge.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeToggle(bool isEmail) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!isEmail) controller.toggleAuthMode();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isEmail
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'email'.tr,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isEmail ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (isEmail) controller.toggleAuthMode();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isEmail
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'phone'.tr,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: !isEmail ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
