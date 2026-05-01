import 'package:dentist_tracker/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../services/version_check_service.dart';
import '../../../update_dialog.dart';
import '../../auth/controllers/auth_controller.dart';

/// Animated splash screen with version check + auth state check.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnim = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    // Version check + auth after animation completes
    Future.delayed(const Duration(milliseconds: 2000), _checkVersionThenAuth);
  }

  /// Step 1: Check remote version config.
  /// Step 2: If force update → block. If optional → show dialog then continue.
  /// Step 3: Check auth session and navigate.
  Future<void> _checkVersionThenAuth() async {
    if (_navigated || !mounted) return;

    final info = await VersionCheckService.check();

    if (!mounted) return;

    if (info.status == UpdateStatus.forceUpdate) {
      // Block the user — dialog is non-dismissible
      await UpdateDialog.show(context, info);
      // If dialog somehow closes (shouldn't for force), re-check
      return;
    }

    if (info.status == UpdateStatus.optionalUpdate) {
      // Show optional update — user can skip
      if (mounted) {
        await UpdateDialog.show(context, info);
      }
    }

    // Proceed to auth check
    _navigateToAuth();
  }

  Future<void> _navigateToAuth() async {
    if (_navigated || !mounted) return;
    _navigated = true;

    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      // Check if the user has a pending deletion request
      final hasDeletion = await AuthController.checkPendingDeletion();
      if (hasDeletion) {
        Get.offAllNamed(AppRoutes.deletionPending);
      } else {
        Get.offAllNamed(AppRoutes.home);
      }
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.authGradient),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnim.value,
                child: Transform.scale(
                  scale: _scaleAnim.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App Icon
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Image.asset(
                            'assets/icon/app_icon.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'app_name'.tr,
                        style: AppTextStyles.displayMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'clinic_subtitle'.tr,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
