import '../../../routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';

/// Premium login screen with gradient background and glassmorphism card.
class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.authGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ─── Logo ────────────────────────────────────────
                  _buildLogo(),
                  const SizedBox(height: 40),

                  // ─── Auth Card ───────────────────────────────────
                  _buildAuthCard(context),

                  const SizedBox(height: 24),

                  // ─── Register Link ───────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'no_account'.tr,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.register),
                        child: Text(
                          'register'.tr,
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
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.medical_services_rounded,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'app_name'.tr,
          style: AppTextStyles.displaySmall.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          'login_subtitle'.tr,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Obx(() {
        final isEmail = controller.authMode.value == 'email';
        final isOtpSent = controller.isOtpSent.value;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Auth Mode Toggle ──────────────────────────
            _buildModeToggle(isEmail),
            const SizedBox(height: 24),

            // ─── Email Mode ────────────────────────────────
            if (isEmail) ...[
              AppTextField(
                controller: controller.emailController,
                hint: 'email'.tr,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),
              AppTextField(
                controller: controller.passwordController,
                hint: 'password'.tr,
                prefixIcon: Icons.lock_outlined,
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              AppButton(
                label: 'login'.tr,
                isLoading: controller.isLoading.value,
                icon: Icons.login_rounded,
                onPressed: controller.loginWithEmail,
              ),
            ],

            // ─── Phone Mode (only if enabled) ──────────────
            if (!isEmail && AppConstants.isPhoneAuthEnabled) ...[
              AppTextField(
                controller: controller.phoneController,
                hint: 'phone'.tr,
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              if (isOtpSent) ...[
                const SizedBox(height: 16),
                AppTextField(
                  controller: controller.otpController,
                  hint: 'enter_otp'.tr,
                  prefixIcon: Icons.lock_outline,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  maxLength: 6,
                ),
              ],
              const SizedBox(height: 20),
              AppButton(
                label: isOtpSent ? 'verify_otp'.tr : 'send_otp'.tr,
                isLoading: controller.isLoading.value,
                icon: isOtpSent ? Icons.verified_outlined : Icons.sms_outlined,
                onPressed: isOtpSent
                    ? controller.verifyPhoneOtp
                    : controller.sendPhoneOtp,
              ),
            ],
          ],
        );
      }),
    );
  }

  Widget _buildModeToggle(bool isEmail) {
    final phoneEnabled = AppConstants.isPhoneAuthEnabled;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // ─── Email Tab ─────────────────────────────────
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
                    'login_with_email'.tr,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isEmail ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ─── Phone Tab (with Coming Soon badge if disabled) ──
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (isEmail) controller.toggleAuthMode();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isEmail && phoneEnabled
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'login_with_phone'.tr,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: phoneEnabled
                                ? (!isEmail ? Colors.white : Colors.white54)
                                : Colors.white38,
                          ),
                        ),
                      ),
                      if (!phoneEnabled) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade700,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'coming_soon'.tr,
                            style: const TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ],
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
