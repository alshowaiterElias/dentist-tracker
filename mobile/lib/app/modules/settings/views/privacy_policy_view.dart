import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Privacy Policy & Terms of Service page.
class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Scaffold(
      appBar: AppBar(title: Text('privacy_policy'.tr)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'privacy_policy'.tr,
            style: AppTextStyles.displaySmall.copyWith(color: textColor),
          ),
          const SizedBox(height: 8),
          Text(
            'privacy_last_updated'.tr,
            style: AppTextStyles.caption.copyWith(color: secondaryColor),
          ),
          const SizedBox(height: 24),

          _sectionTitle('privacy_section_1_title'.tr, textColor),
          _sectionBody('privacy_section_1_body'.tr, secondaryColor),

          _sectionTitle('privacy_section_2_title'.tr, textColor),
          _sectionBody('privacy_section_2_body'.tr, secondaryColor),

          _sectionTitle('privacy_section_3_title'.tr, textColor),
          _sectionBody('privacy_section_3_body'.tr, secondaryColor),

          _sectionTitle('privacy_section_4_title'.tr, textColor),
          _sectionBody('privacy_section_4_body'.tr, secondaryColor),

          _sectionTitle('privacy_section_5_title'.tr, textColor),
          _sectionBody('privacy_section_5_body'.tr, secondaryColor),

          const SizedBox(height: 32),
          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          const SizedBox(height: 32),

          Text(
            'terms_of_service'.tr,
            style: AppTextStyles.displaySmall.copyWith(color: textColor),
          ),
          const SizedBox(height: 8),
          Text(
            'tos_last_updated'.tr,
            style: AppTextStyles.caption.copyWith(color: secondaryColor),
          ),
          const SizedBox(height: 24),

          _sectionTitle('tos_section_1_title'.tr, textColor),
          _sectionBody('tos_section_1_body'.tr, secondaryColor),

          _sectionTitle('tos_section_2_title'.tr, textColor),
          _sectionBody('tos_section_2_body'.tr, secondaryColor),

          _sectionTitle('tos_section_3_title'.tr, textColor),
          _sectionBody('tos_section_3_body'.tr, secondaryColor),

          _sectionTitle('tos_section_4_title'.tr, textColor),
          _sectionBody('tos_section_4_body'.tr, secondaryColor),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        title,
        style: AppTextStyles.headingSmall.copyWith(color: color),
      ),
    );
  }

  Widget _sectionBody(String body, Color color) {
    return Text(
      body,
      style: AppTextStyles.bodyMedium.copyWith(
        color: color,
        height: 1.7,
      ),
    );
  }
}
