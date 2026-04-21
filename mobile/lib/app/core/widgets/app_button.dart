import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Premium button with multiple variants, loading state, and gradient support.
enum AppButtonVariant { primary, secondary, outline, ghost, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;
  final IconData? icon;
  final double? height;
  final EdgeInsets? padding;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isExpanded = true,
    this.icon,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final h = height ?? 54;

    Widget button = switch (variant) {
      AppButtonVariant.primary => _buildPrimary(context, isDark, h),
      AppButtonVariant.secondary => _buildSecondary(context, isDark, h),
      AppButtonVariant.outline => _buildOutline(context, isDark, h),
      AppButtonVariant.ghost => _buildGhost(context, isDark, h),
      AppButtonVariant.danger => _buildDanger(context, isDark, h),
    };

    if (isExpanded) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: onPressed == null && !isLoading ? 0.5 : 1.0,
      child: button,
    );
  }

  Widget _buildChild(Color textColor) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation(textColor),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.button),
        ],
      );
    }

    return Text(label, style: AppTextStyles.button);
  }

  Widget _buildPrimary(BuildContext context, bool isDark, double h) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: onPressed != null
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: h,
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            alignment: Alignment.center,
            child: _buildChild(Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondary(BuildContext context, bool isDark, double h) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? AppColors.darkCardElevated : AppColors.lightCardElevated,
        foregroundColor: isDark ? AppColors.darkText : AppColors.lightText,
        minimumSize: Size(0, h),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: _buildChild(isDark ? AppColors.darkText : AppColors.lightText),
    );
  }

  Widget _buildOutline(BuildContext context, bool isDark, double h) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(0, h),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(
          color: isDark ? AppColors.primaryLight : AppColors.primary,
          width: 1.5,
        ),
      ),
      child: _buildChild(isDark ? AppColors.primaryLight : AppColors.primary),
    );
  }

  Widget _buildGhost(BuildContext context, bool isDark, double h) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(0, h),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: _buildChild(isDark ? AppColors.primaryLight : AppColors.primary),
    );
  }

  Widget _buildDanger(BuildContext context, bool isDark, double h) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.errorGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: h,
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            alignment: Alignment.center,
            child: _buildChild(Colors.white),
          ),
        ),
      ),
    );
  }
}
