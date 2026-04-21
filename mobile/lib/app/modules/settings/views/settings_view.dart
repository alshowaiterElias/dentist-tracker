import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../data/models/profile_model.dart';
import '../../../routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/views/email_verification_view.dart';

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

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    _profile = await _repo.getProfile();
    setState(() => _isLoading = false);
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
                const SizedBox(height: 32),

                // ─── Version ─────────────────────────────────
                Center(
                  child: Text(
                    '${'version'.tr} 1.0.0',
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
