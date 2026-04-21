import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';

/// Email verification waiting screen, shown after sign-up before email is confirmed.
class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  final _supabase = Supabase.instance.client;
  bool _isResending = false;
  String _email = '';

  @override
  void initState() {
    super.initState();
    // Get email from args or from current unconfirmed user
    final args = Get.arguments;
    if (args is Map && args['email'] != null) {
      _email = args['email'] as String;
    } else {
      _email = _supabase.auth.currentUser?.email ?? '';
    }
  }

  Future<void> _resendEmail() async {
    if (_email.isEmpty) return;
    setState(() => _isResending = true);
    try {
      await _supabase.auth.resend(
        type: OtpType.signup,
        email: _email,
        emailRedirectTo: 'com.dentisttracker://login-callback',
      );
      Get.snackbar(
        'success'.tr,
        'confirm_email_sent'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    } on AuthException catch (e) {
      Get.snackbar('error'.tr, e.message, snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.authGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mark_email_unread_outlined,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 32),

                Text(
                  'verify_email'.tr,
                  style: AppTextStyles.displaySmall.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  '${'verify_email_desc'.tr}\n$_email',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: Colors.white.withValues(alpha: 0.8)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Resend button
                AppButton(
                  label: 'resend_email'.tr,
                  isLoading: _isResending,
                  icon: Icons.send_rounded,
                  onPressed: _resendEmail,
                ),
                const SizedBox(height: 16),

                // Back to login
                TextButton(
                  onPressed: () => Get.offAllNamed('/login'),
                  child: Text(
                    'back_to_login'.tr,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Change Password Bottom Sheet ─────────────────────────────────────────────

/// Call this to show the change-password sheet from anywhere.
void showChangePasswordSheet(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final currentCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final isSubmitting = false.obs;
  final formKey = GlobalKey<FormState>();

  Get.bottomSheet(
    _ChangePasswordSheet(
      isDark: isDark,
      currentCtrl: currentCtrl,
      newCtrl: newCtrl,
      confirmCtrl: confirmCtrl,
      isSubmitting: isSubmitting,
      formKey: formKey,
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class _ChangePasswordSheet extends StatelessWidget {
  final bool isDark;
  final TextEditingController currentCtrl;
  final TextEditingController newCtrl;
  final TextEditingController confirmCtrl;
  final RxBool isSubmitting;
  final GlobalKey<FormState> formKey;

  const _ChangePasswordSheet({
    required this.isDark,
    required this.currentCtrl,
    required this.newCtrl,
    required this.confirmCtrl,
    required this.isSubmitting,
    required this.formKey,
  });

  Future<void> _submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isSubmitting.value = true;
    try {
      final supabase = Supabase.instance.client;
      // Re-auth with current password first
      final user = supabase.auth.currentUser;
      if (user?.email == null) throw Exception('No email on account');

      await supabase.auth.signInWithPassword(
        email: user!.email!,
        password: currentCtrl.text.trim(),
      );
      // Update to new password
      await supabase.auth.updateUser(
        UserAttributes(password: newCtrl.text.trim()),
      );
      Get.back();
      Get.snackbar(
        'success'.tr,
        'password_changed'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AuthException catch (e) {
      Get.snackbar('error'.tr, e.message, snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.lightBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('change_password'.tr, style: AppTextStyles.headingMedium),
              const SizedBox(height: 20),
              AppTextField(
                controller: currentCtrl,
                label: 'current_password'.tr,
                hint: '••••••••',
                prefixIcon: Icons.lock_outlined,
                obscureText: true,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'required'.tr : null,
              ),
              const SizedBox(height: 14),
              AppTextField(
                controller: newCtrl,
                label: 'new_password'.tr,
                hint: '••••••••',
                prefixIcon: Icons.lock_reset_outlined,
                obscureText: true,
                validator: Validators.password,
              ),
              const SizedBox(height: 14),
              AppTextField(
                controller: confirmCtrl,
                label: 'confirm_password'.tr,
                hint: '••••••••',
                prefixIcon: Icons.lock_reset_outlined,
                obscureText: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'required'.tr;
                  if (v != newCtrl.text) return 'passwords_dont_match'.tr;
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Obx(() => AppButton(
                    label: 'save'.tr,
                    isLoading: isSubmitting.value,
                    icon: Icons.check_rounded,
                    onPressed: _submit,
                  )),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
