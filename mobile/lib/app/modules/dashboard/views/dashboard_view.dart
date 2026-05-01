import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/payment_sheet.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/daily_visit_model.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../routes/app_routes.dart';
import '../controllers/dashboard_controller.dart';

/// Dashboard with an 8-day swipable patient schedule table.
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
              _buildAppBar(isDark),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Day tab bar
                    _buildDayTabs(isDark),
                    const SizedBox(height: 16),
                    // Schedule table
                    _buildScheduleTable(isDark),
                    const SizedBox(height: 16),
                    // Daily summary
                    _buildDailySummary(isDark),
                    const SizedBox(height: 80), // FAB clearance
                  ]),
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: _buildFAB(isDark),
    );
  }

  // ─── App Bar ──────────────────────────────────────────────────────

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
    if (hour < 12) return 'good_morning'.tr;
    if (hour < 17) return 'good_afternoon'.tr;
    return 'good_evening'.tr;
  }

  // ─── Day Tabs ─────────────────────────────────────────────────────

  Widget _buildDayTabs(bool isDark) {
    final dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return SizedBox(
      height: 64,
      child: Obx(() {
        final selectedIdx = controller.selectedDayIndex.value;
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.weekDates.length,
            itemBuilder: (context, index) {
              final date = controller.weekDates[index];
              final isSelected = selectedIdx == index;
              final isToday = index == 0;
              final dayName = isToday ? 'today'.tr : dayNames[date.weekday % 7];

              return GestureDetector(
                onTap: () => controller.loadDay(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? AppColors.primaryLight : AppColors.primary)
                        : (isDark
                            ? AppColors.darkCardElevated
                            : AppColors.lightCardElevated),
                    borderRadius: BorderRadius.circular(16),
                    border: isToday && !isSelected
                        ? Border.all(
                            color: isDark
                                ? AppColors.primaryLight
                                : AppColors.primary,
                            width: 1.5,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayName.toUpperCase(),
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 9,
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${date.day}',
                        style: AppTextStyles.headingSmall.copyWith(
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                  ? AppColors.darkText
                                  : AppColors.lightText),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
        );
      }),
    );
  }

  // ─── Schedule Table ───────────────────────────────────────────────

  Widget _buildScheduleTable(bool isDark) {
    return Obx(() {
      final visits = controller.dailyVisits;

      if (visits.isEmpty) {
        return AppCard(
          padding: const EdgeInsets.all(32),
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

      return AppCard(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder(
              verticalInside: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 0.5,
              ),
              horizontalInside: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 0.5,
              ),
            ),
            columnSpacing: 16,
            horizontalMargin: 12,
            headingRowHeight: 44,
            dataRowMinHeight: 52,
            dataRowMaxHeight: 60,
            headingTextStyle: AppTextStyles.labelSmall.copyWith(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              fontWeight: FontWeight.w700,
            ),
            columns: [
              DataColumn(label: Text('✓')),
              DataColumn(label: Text('patient'.tr)),
              DataColumn(label: Text('treatment'.tr)),
              DataColumn(label: Text('total_cost'.tr), numeric: true),
              DataColumn(label: Text('amount_paid'.tr), numeric: true),
              DataColumn(label: Text('remaining_balance'.tr), numeric: true),
              DataColumn(label: Text('next_appointment'.tr)),
              DataColumn(label: Text('actions'.tr)),
            ],
            rows: visits.map((v) => _buildRow(v, isDark)).toList(),
          ),
        ),
      );
    });
  }

  DataRow _buildRow(DailyVisitModel v, bool isDark) {
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return DataRow(
      cells: [
        // ✓ Checkbox
        DataCell(
          Checkbox(
            value: v.attended,
            activeColor: AppColors.success,
            onChanged: (_) => controller.toggleAttendance(v.appointmentId),
          ),
        ),
        // Patient name (tappable)
        DataCell(
          InkWell(
            onTap: () =>
                Get.toNamed(AppRoutes.patientDetail, arguments: v.patientId),
            child: Text(
              v.patientName,
              style: AppTextStyles.labelMedium.copyWith(
                color: isDark ? AppColors.primaryLight : AppColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        // Treatment type
        DataCell(
          Text(
            v.procedureType ?? '—',
            style: AppTextStyles.bodySmall.copyWith(color: textColor),
          ),
        ),
        // Total cost
        DataCell(
          Text(
            Formatters.currency(v.totalCost),
            style: AppTextStyles.labelSmall.copyWith(color: textColor),
          ),
        ),
        // Amount paid
        DataCell(
          Text(
            Formatters.currency(v.amountPaid),
            style: AppTextStyles.labelSmall.copyWith(color: AppColors.success),
          ),
        ),
        // Remaining
        DataCell(
          Text(
            Formatters.currency(v.remaining),
            style: AppTextStyles.labelSmall.copyWith(
              color: v.remaining > 0 ? AppColors.warning : AppColors.success,
            ),
          ),
        ),
        // Next appointment
        DataCell(
          Text(
            v.nextAppointment != null
                ? Formatters.dateShortEn(v.nextAppointment!)
                : '—',
            style: AppTextStyles.caption.copyWith(color: subColor),
          ),
        ),
        // Pay action
        DataCell(
          IconButton(
            icon: const Icon(Icons.payments_outlined, size: 20),
            color: AppColors.primary,
            tooltip: 'record_payment'.tr,
            onPressed: v.treatmentId != null
                ? () => _showPayment(v)
                : null,
          ),
        ),
      ],
    );
  }

  Future<void> _showPayment(DailyVisitModel v) async {
    if (v.treatmentId == null) return;
    final repo = AppRepository();
    final treatment = await repo.getTreatment(v.treatmentId!);
    if (treatment == null) return;

    final ctx = Get.context;
    if (ctx == null || !ctx.mounted) return;

    PaymentSheet.show(
      context: ctx,
      treatment: treatment,
      onPaymentRecorded: () => controller.refreshDashboard(),
    );
  }

  // ─── Daily Summary ────────────────────────────────────────────────

  Widget _buildDailySummary(bool isDark) {
    return Obx(() {
      if (controller.dailyVisits.isEmpty) return const SizedBox.shrink();

      return GradientCard(
        gradient: AppColors.primaryGradient,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'daily_summary'.tr,
              style: AppTextStyles.labelLarge.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _summaryItem('total_cost'.tr,
                    Formatters.currency(controller.dayTotalCost)),
                _summaryItem('amount_paid'.tr,
                    Formatters.currency(controller.dayTotalPaid)),
                _summaryItem('remaining_balance'.tr,
                    Formatters.currency(controller.dayTotalRemaining)),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _summaryItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.headingSmall
                .copyWith(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ─── FAB ──────────────────────────────────────────────────────────

  Widget _buildFAB(bool isDark) {
    return FloatingActionButton(
      heroTag: 'dashboard_fab',
      onPressed: () => _showAddMenu(),
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.add_rounded, color: Colors.white),
    );
  }

  void _showAddMenu() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Text('quick_add'.tr, style: AppTextStyles.headingMedium),
            const SizedBox(height: 20),
            _menuTile(
              icon: Icons.person_add_rounded,
              color: AppColors.primary,
              title: 'new_patient_visit'.tr,
              subtitle: 'new_patient_visit_desc'.tr,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.newPatientVisit);
              },
            ),
            const SizedBox(height: 12),
            _menuTile(
              icon: Icons.person_search_rounded,
              color: AppColors.accent,
              title: 'returning_patient_visit'.tr,
              subtitle: 'returning_patient_visit_desc'.tr,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.returningPatientVisit);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final isDark = Get.isDarkMode;
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: isDark
                ? AppColors.darkTextTertiary
                : AppColors.lightTextTertiary,
          ),
        ],
      ),
    );
  }
}
