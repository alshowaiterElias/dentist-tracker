import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../data/models/profile_model.dart';
import '../../../routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/views/email_verification_view.dart';
import '../../../services/sync_service.dart';
import '../../../services/connectivity_service.dart';
import 'support_view.dart';

/// Settings screen: profile, revenue %, language, theme, logout.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _repo = AppRepository();
  final _storage = GetStorage();
  ProfileModel? _profile;
  bool _isLoading = true;
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadVersion();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    _profile = await _repo.getProfile();
    setState(() => _isLoading = false);
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() => _appVersion = '${info.version}+${info.buildNumber}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // ─── Profile Section ─────────────────────────
                _buildProfileSection(isDark),
                const SizedBox(height: 24),

                // ─── Revenue Percentage ──────────────────────
                _buildRevenueSection(isDark),
                const SizedBox(height: 24),

                // ─── Security ───────────────────────────────
                _buildSectionTitle('security'.tr, isDark),
                const SizedBox(height: 12),
                AppCard(
                  onTap: () => showChangePasswordSheet(context),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_reset_outlined,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'change_password'.tr,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ─── Data & Sync ─────────────────────────────
                _buildSectionTitle('data_sync'.tr, isDark),
                const SizedBox(height: 12),
                Obx(() {
                  final sync = SyncService.to;
                  final online = ConnectivityService.to.isOnline.value;
                  final pending = sync.pendingCount.value;
                  final syncing = sync.isSyncing.value;

                  return AppCard(
                    onTap: (!online || syncing)
                        ? null
                        : () async {
                            await sync.processQueue();
                            final remaining = sync.pendingCount.value;
                            if (remaining > 0) {
                              Get.snackbar(
                                'warning'.tr,
                                '$remaining ${'pending_changes'.tr} — ${'sync_failed_hint'.tr}',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 5),
                              );
                            } else {
                              Get.snackbar(
                                'success'.tr,
                                'sync_complete'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          syncing
                              ? Icons.sync_rounded
                              : Icons.cloud_sync_outlined,
                          color: online
                              ? (isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary)
                              : (isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'sync_now'.tr,
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                syncing
                                    ? 'syncing'.tr
                                    : !online
                                        ? 'offline'.tr
                                        : pending > 0
                                            ? '$pending ${'pending_changes'.tr}'
                                            : 'all_synced'.tr,
                                style: AppTextStyles.caption.copyWith(
                                  color: isDark
                                      ? AppColors.darkTextTertiary
                                      : AppColors.lightTextTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (syncing)
                          const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        else if (pending > 0 && online)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.warning
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$pending',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.warning,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 24),

                // ─── Appearance ──────────────────────────────
                _buildSectionTitle('theme'.tr, isDark),
                const SizedBox(height: 12),
                _buildThemeSelector(isDark),
                const SizedBox(height: 24),

                // ─── Language ────────────────────────────────
                _buildSectionTitle('language'.tr, isDark),
                const SizedBox(height: 12),
                _buildLanguageSelector(isDark),
                const SizedBox(height: 32),

                // ─── About & Legal ───────────────────────────
                _buildSectionTitle('about'.tr, isDark),
                const SizedBox(height: 12),
                AppCard(
                  onTap: () => Get.toNamed(AppRoutes.about),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'about_app'.tr,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                AppCard(
                  onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'privacy_and_terms'.tr,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                AppCard(
                  onTap: () => Get.to(() => const SupportView()),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.headset_mic_rounded,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'contact_support'.tr,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ─── Logout ──────────────────────────────────
                AppCard(
                  onTap: _logout,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout_rounded,
                        color: AppColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'logout'.tr,
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ─── Delete Account ──────────────────────────
                AppCard(
                  onTap: _requestDeleteAccount,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.red.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'delete_account'.tr,
                        style: AppTextStyles.labelLarge.copyWith(
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ─── Version ─────────────────────────────────
                Center(
                  child: Text(
                    '${'version'.tr} ${_appVersion.isNotEmpty ? _appVersion : '...'}',
                    style: AppTextStyles.caption.copyWith(
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.overline.copyWith(
        color: isDark
            ? AppColors.darkTextTertiary
            : AppColors.lightTextTertiary,
      ),
    );
  }

  Widget _buildProfileSection(bool isDark) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                (_profile?.fullName ?? '?')[0].toUpperCase(),
                style: AppTextStyles.displaySmall.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _profile?.fullName ?? '',
                  style: AppTextStyles.headingMedium.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _profile?.email ?? _profile?.phone ?? '',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueSection(bool isDark) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.percent_rounded,
                size: 20,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'revenue_percentage'.tr,
                style: AppTextStyles.labelLarge.copyWith(
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'revenue_percentage_desc'.tr,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _profile?.revenuePercentage ?? 100,
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '${(_profile?.revenuePercentage ?? 100).round()}%',
                  onChanged: (v) {
                    setState(() {
                      _profile = _profile?.copyWith(revenuePercentage: v);
                    });
                  },
                  onChangeEnd: (v) async {
                    await _repo.updateProfile({'revenue_percentage': v});
                    Get.snackbar(
                      'success'.tr,
                      'settings_saved'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
              SizedBox(
                width: 56,
                child: Text(
                  '${(_profile?.revenuePercentage ?? 100).round()}%',
                  style: AppTextStyles.headingSmall.copyWith(
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(bool isDark) {
    final currentTheme =
        _storage.read<String>(AppConstants.storageThemeKey) ?? 'system';

    return Row(
      children: [
        _themeOption(
          'light',
          Icons.light_mode_rounded,
          'light_mode'.tr,
          isDark,
          currentTheme,
        ),
        const SizedBox(width: 10),
        _themeOption(
          'dark',
          Icons.dark_mode_rounded,
          'dark_mode'.tr,
          isDark,
          currentTheme,
        ),
        const SizedBox(width: 10),
        _themeOption(
          'system',
          Icons.settings_suggest_rounded,
          'system_theme'.tr,
          isDark,
          currentTheme,
        ),
      ],
    );
  }

  Widget _themeOption(
    String value,
    IconData icon,
    String label,
    bool isDark,
    String current,
  ) {
    final isSelected = current == value;
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          _storage.write(AppConstants.storageThemeKey, value);
          switch (value) {
            case 'light':
              Get.changeThemeMode(ThemeMode.light);
              break;
            case 'dark':
              Get.changeThemeMode(ThemeMode.dark);
              break;
            default:
              Get.changeThemeMode(ThemeMode.system);
          }
          setState(() {});
        },
        child: AppCard(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    : (isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary),
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: isSelected
                      ? (isDark ? AppColors.primaryLight : AppColors.primary)
                      : (isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(bool isDark) {
    final currentLang =
        _storage.read<String>(AppConstants.storageLocaleKey) ?? 'en';

    return Row(
      children: [
        Expanded(child: _langOption('en', 'english'.tr, isDark, currentLang)),
        const SizedBox(width: 10),
        Expanded(child: _langOption('ar', 'arabic'.tr, isDark, currentLang)),
      ],
    );
  }

  Widget _langOption(String code, String label, bool isDark, String current) {
    final isSelected = current == code;
    return GestureDetector(
      onTap: () async {
        _storage.write(AppConstants.storageLocaleKey, code);
        if (code == 'ar') {
          Get.updateLocale(const Locale('ar', 'SA'));
        } else {
          Get.updateLocale(const Locale('en', 'US'));
        }
        await _repo.updateProfile({'preferred_language': code});
        setState(() {});
      },
      child: AppCard(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.labelLarge.copyWith(
              color: isSelected
                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                  : (isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _requestDeleteAccount() async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red.shade700, size: 24),
            const SizedBox(width: 8),
            Text('delete_account'.tr),
          ],
        ),
        content: Text('delete_account_confirm'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              'delete'.tr,
              style: TextStyle(color: Colors.red.shade700),
            ),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    // Second confirmation with typed text
    final confirmText = await Get.dialog<String>(
      _DeleteConfirmDialog(),
    );
    if (confirmText != 'DELETE') return;

    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;

      // Insert a deletion request — admin will process it
      await Supabase.instance.client.from('account_deletion_requests').insert({
        'user_id': userId,
        'email': _profile?.email ?? '',
        'requested_at': DateTime.now().toIso8601String(),
        'status': 'pending',
      });

      // Sign out
      await Supabase.instance.client.auth.signOut();

      Get.offAllNamed(AppRoutes.login);
      Get.snackbar(
        'success'.tr,
        'delete_account_requested'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 6),
      );
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _logout() async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: Text('logout'.tr),
        content: Text('logout_confirm'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              'logout'.tr,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirm == true) {
      Get.find<AuthController>().logout();
    }
  }
}

/// Dialog that asks the user to type "DELETE" to confirm account deletion.
class _DeleteConfirmDialog extends StatelessWidget {
  final _ctrl = TextEditingController();

  _DeleteConfirmDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('delete_account_type_confirm'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'delete_account_type_desc'.tr,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ctrl,
            decoration: const InputDecoration(
              hintText: 'DELETE',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.characters,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: null),
          child: Text('cancel'.tr),
        ),
        TextButton(
          onPressed: () => Get.back(result: _ctrl.text.trim()),
          child: Text(
            'confirm'.tr,
            style: TextStyle(color: Colors.red.shade700),
          ),
        ),
      ],
    );
  }
}
