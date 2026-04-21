import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/connectivity_service.dart';
import '../../../services/sync_service.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../patients/views/patient_list_view.dart';
import '../../appointments/views/calendar_view.dart';
import '../../reports/views/reports_view.dart';
import '../controllers/home_controller.dart';

/// Main app shell with premium bottom navigation bar.
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Use GlobalKeys to access child state for refreshing
    final calendarKey = GlobalKey<CalendarViewState>();
    final reportsKey = GlobalKey<ReportsViewState>();

    // Listen for tab changes to refresh data
    ever(controller.currentIndex, (int index) {
      if (index == 2) {
        calendarKey.currentState?.refreshData();
      } else if (index == 3) {
        reportsKey.currentState?.refreshData();
      }
    });

    final pages = <Widget>[
      const DashboardView(),
      const PatientListView(),
      CalendarView(key: calendarKey),
      ReportsView(key: reportsKey),
    ];

    return Obx(() => Scaffold(
          body: Stack(
            children: [
              IndexedStack(
                index: controller.currentIndex.value,
                children: pages,
              ),
              // ── Offline / Sync Banner ──────────────────────────
              _OfflineBanner(isDark: isDark),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      index: 0,
                      icon: Icons.dashboard_rounded,
                      label: 'dashboard'.tr,
                      isDark: isDark,
                    ),
                    _buildNavItem(
                      index: 1,
                      icon: Icons.people_rounded,
                      label: 'patients'.tr,
                      isDark: isDark,
                    ),
                    _buildNavItem(
                      index: 2,
                      icon: Icons.calendar_month_rounded,
                      label: 'calendar'.tr,
                      isDark: isDark,
                    ),
                    _buildNavItem(
                      index: 3,
                      icon: Icons.bar_chart_rounded,
                      label: 'reports'.tr,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    final isSelected = controller.currentIndex.value == index;
    final activeColor = isDark ? AppColors.primaryLight : AppColors.primary;
    final inactiveColor =
        isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary;

    return GestureDetector(
      onTap: () => controller.changePage(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? activeColor : inactiveColor,
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: isSelected ? 11 : 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Offline / Sync Banner ────────────────────────────────────────────────────

class _OfflineBanner extends StatelessWidget {
  final bool isDark;
  const _OfflineBanner({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final connectivity = ConnectivityService.to;
    final sync = SyncService.to;

    return Obx(() {
      final online = connectivity.isOnline.value;
      final pending = sync.pendingCount.value;
      final syncing = sync.isSyncing.value;

      // Nothing to show when online with no pending ops
      if (online && pending == 0 && !syncing) return const SizedBox.shrink();

      Color bgColor;
      IconData icon;
      String message;

      if (!online) {
        bgColor = Colors.amber.shade700;
        icon = Icons.wifi_off_rounded;
        message = pending > 0
            ? 'Offline · $pending change${pending == 1 ? '' : 's'} pending'
            : 'Offline';
      } else if (syncing) {
        bgColor = AppColors.primary;
        icon = Icons.sync_rounded;
        message = 'Syncing changes…';
      } else {
        // online, not syncing, but pending > 0 (edge case)
        bgColor = Colors.orange.shade600;
        icon = Icons.cloud_upload_rounded;
        message = '$pending pending sync${pending == 1 ? '' : 's'}';
      }

      return Positioned(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        child: AnimatedSlide(
          offset: Offset.zero,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  syncing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(icon, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
