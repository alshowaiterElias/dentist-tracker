import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';

/// About the app page.
class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text('about'.tr)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),

          // App icon
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.medical_services_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // App name
          Center(
            child: Text(
              'app_name'.tr,
              style: AppTextStyles.displaySmall.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              '${'version'.tr} 1.0.0',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Description
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Text(
              'about_description'.tr,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Features
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'features'.tr,
                  style: AppTextStyles.headingSmall.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 16),
                _featureItem(Icons.people_rounded, 'feature_patients'.tr, isDark),
                _featureItem(Icons.medical_services_rounded, 'feature_treatments'.tr, isDark),
                _featureItem(Icons.calendar_month_rounded, 'feature_appointments'.tr, isDark),
                _featureItem(Icons.medication_rounded, 'feature_medications'.tr, isDark),
                _featureItem(Icons.bar_chart_rounded, 'feature_reports'.tr, isDark),
                _featureItem(Icons.attach_file_rounded, 'feature_files'.tr, isDark),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Developer info
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  Icons.code_rounded,
                  size: 28,
                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  'developed_with_love'.tr,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _featureItem(IconData icon, String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
