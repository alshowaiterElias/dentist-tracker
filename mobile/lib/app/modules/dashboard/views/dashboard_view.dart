import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/utils/formatters.dart';
import '../../../routes/app_routes.dart';
import '../controllers/dashboard_controller.dart';

/// Premium dashboard with animated cards, today's appointments, and financial summary.
class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshDashboard,
          color: AppColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // ─── App Bar ──────────────────────────────────
              _buildAppBar(isDark),

              // ─── Content ──────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Financial Cards
                    _buildFinancialCards(isDark),
                    const SizedBox(height: 24),

                    // Today's Appointments
                    _buildSectionHeader(
                      'todays_appointments'.tr,
                      icon: Icons.today_rounded,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    _buildTodayAppointments(isDark),
                    const SizedBox(height: 24),

                    // Quick Actions
                    _buildSectionHeader(
                      'quick_actions'.tr,
                      icon: Icons.flash_on_rounded,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    _buildQuickActions(isDark),
                  ]),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ─── App Bar ─────────────────────────────────────────────────
  Widget _buildAppBar(bool isDark) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 16),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getGreeting(),
              style: AppTextStyles.labelSmall.copyWith(
                color: isDark ? AppColors.primaryLight : AppColors.primary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              controller.profile.value?.fullName ?? 'Doctor',
              style: AppTextStyles.headingMedium.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 16),
          child: IconButton(
            onPressed: () => Get.toNamed(AppRoutes.settings),
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkCardElevated
                    : AppColors.lightCardElevated,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.settings_outlined,
                size: 20,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'GOOD MORNING';
    if (hour < 17) return 'GOOD AFTERNOON';
    return 'GOOD EVENING';
  }

  // ─── Financial Cards ─────────────────────────────────────────
  Widget _buildFinancialCards(bool isDark) {
    return Column(
      children: [
        // Primary earnings card with gradient
        GradientCard(
          gradient: AppColors.primaryGradient,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.account_balance_wallet_rounded,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'dentist_earnings'.tr,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                Formatters.currency(controller.dentistEarnings),
                style: AppTextStyles.displayMedium.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${Formatters.percentage(controller.profile.value?.revenuePercentage ?? 100)} ${'revenue'.tr}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Secondary cards row
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'total_income'.tr,
                value: Formatters.currency(controller.totalIncome),
                icon: Icons.trending_up_rounded,
                color: AppColors.success,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                title: 'total_paid'.tr,
                value: Formatters.currency(controller.totalPaid),
                icon: Icons.check_circle_outline_rounded,
                color: AppColors.info,
                isDark: isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'total_unpaid'.tr,
                value: Formatters.currency(controller.totalUnpaid),
                icon: Icons.access_time_rounded,
                color: AppColors.warning,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                title: 'patients'.tr,
                value: Formatters.number(controller.totalPatients),
                icon: Icons.people_rounded,
                color: AppColors.accent,
                isDark: isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.amountSmall.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: isDark
                  ? AppColors.darkTextTertiary
                  : AppColors.lightTextTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title,
      {required IconData icon, required bool isDark}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDark ? AppColors.primaryLight : AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyles.headingSmall.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ],
    );
  }

  // ─── Today's Appointments ────────────────────────────────────
  Widget _buildTodayAppointments(bool isDark) {
    if (controller.todayAppointments.isEmpty) {
      return AppCard(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.free_breakfast_rounded,
                size: 40,
                color: isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
              ),
              const SizedBox(height: 12),
              Text(
                'no_appointments_today'.tr,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: controller.todayAppointments.map((apt) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: AppCard(
            onTap: () => Get.toNamed(
              AppRoutes.patientDetail,
              arguments: apt.patientId,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Patient avatar
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primaryDark.withValues(alpha: 0.3)
                        : AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      (apt.patientName ?? '?')[0].toUpperCase(),
                      style: AppTextStyles.headingSmall.copyWith(
                        color: isDark
                            ? AppColors.primaryLight
                            : AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Patient info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apt.patientName ?? 'Unknown',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                      if (apt.notes != null && apt.notes!.isNotEmpty)
                        Text(
                          apt.notes!,
                          style: AppTextStyles.caption.copyWith(
                            color: isDark
                                ? AppColors.darkTextTertiary
                                : AppColors.lightTextTertiary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                // Status badge
                _buildStatusBadge(apt.status, isDark),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusBadge(String status, bool isDark) {
    Color color;
    String label;
    switch (status) {
      case 'completed':
        color = AppColors.success;
        label = 'completed'.tr;
        break;
      case 'no_show':
        color = AppColors.error;
        label = 'no_show'.tr;
        break;
      default:
        color = AppColors.info;
        label = 'scheduled'.tr;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(color: color),
      ),
    );
  }

  // ─── Quick Actions ───────────────────────────────────────────
  Widget _buildQuickActions(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.person_add_rounded,
            label: 'add_patient'.tr,
            color: AppColors.primary,
            isDark: isDark,
            onTap: () => Get.toNamed(AppRoutes.addPatient),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.calendar_month_rounded,
            label: 'add_appointment'.tr,
            color: AppColors.accent,
            isDark: isDark,
            onTap: () => Get.toNamed(AppRoutes.addAppointment),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
