import 'package:dentist_tracker/app/services/version_check_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_text_styles.dart';

/// Shows a version update dialog.
///
/// - [forceUpdate] = true  → non-dismissible, only "Update Now" button
/// - [forceUpdate] = false → dismissible, "Update" + "Later" buttons
class UpdateDialog {
  UpdateDialog._();

  /// Show the appropriate update dialog based on [VersionInfo].
  /// Returns `true` if the user chose to skip (optional), `false` if force-blocked.
  static Future<bool> show(BuildContext context, VersionInfo info) async {
    final isForced = info.status == UpdateStatus.forceUpdate;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: !isForced,
      builder: (ctx) => PopScope(
        canPop: !isForced,
        child: _UpdateDialogContent(info: info, isForced: isForced),
      ),
    );

    return result ?? !isForced;
  }
}

class _UpdateDialogContent extends StatelessWidget {
  final VersionInfo info;
  final bool isForced;

  const _UpdateDialogContent({required this.info, required this.isForced});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 380),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ─── Icon ──────────────────────────────────────────
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: isForced
                      ? LinearGradient(
                          colors: [Colors.red.shade400, Colors.orange.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isForced
                      ? Icons.system_update_rounded
                      : Icons.upgrade_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(height: 20),

              // ─── Title ─────────────────────────────────────────
              Text(
                isForced ? 'update_required'.tr : 'update_available'.tr,
                style: AppTextStyles.headingSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // ─── Message ───────────────────────────────────────
              Text(
                info.updateMessage.isNotEmpty
                    ? info.updateMessage
                    : (isForced
                          ? 'update_required_desc'.tr
                          : 'update_available_desc'.tr),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // ─── Version Info ──────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${'current_version'.tr}: ${info.currentVersion}',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.lightTextTertiary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.lightTextTertiary,
                      ),
                    ),
                    Text(
                      info.latestVersion,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ─── Buttons ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => _openStore(info.storeUrl),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isForced
                        ? Colors.red.shade600
                        : AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.download_rounded, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'update_now'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // "Later" button only for optional updates
              if (!isForced) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: TextButton.styleFrom(
                      foregroundColor: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'update_later'.tr,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openStore(String url) async {
    if (url.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'store_url_not_set'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'error'.tr,
        'could_not_open_store'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
