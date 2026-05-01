import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../routes/app_routes.dart';

/// Screen shown when a user logs in but has a pending account deletion request.
/// They cannot access the app — they must either cancel the request or wait.
class DeletionPendingView extends StatelessWidget {
  const DeletionPendingView({super.key});

  Future<void> _cancelDeletion() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;

      await Supabase.instance.client
          .from('account_deletion_requests')
          .delete()
          .eq('user_id', userId)
          .eq('status', 'pending');

      Get.snackbar(
        'success'.tr,
        'deletion_cancelled'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _signOut() async {
    await Supabase.instance.client.auth.signOut();
    Get.offAllNamed(AppRoutes.login);
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
                // Warning icon
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: Colors.red.shade400.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red.shade300,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 32),

                Text(
                  'deletion_pending_title'.tr,
                  style:
                      AppTextStyles.displaySmall.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'deletion_pending_desc'.tr,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: Colors.white.withValues(alpha: 0.8)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Cancel deletion button
                AppButton(
                  label: 'cancel_deletion'.tr,
                  icon: Icons.restore_rounded,
                  onPressed: _cancelDeletion,
                ),
                const SizedBox(height: 16),

                // Sign out button
                TextButton(
                  onPressed: _signOut,
                  child: Text(
                    'sign_out'.tr,
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
