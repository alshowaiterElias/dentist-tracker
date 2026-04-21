import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/appointment_model.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../routes/app_routes.dart';

/// Monthly calendar view with event markers.
class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarView> {
  final _repo = AppRepository();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Map<DateTime, List<AppointmentModel>> _events = {};
  List<AppointmentModel> _selectedDayAppointments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMonthAppointments();
  }

  /// Called by HomeView when this tab becomes active
  void refreshData() {
    _loadMonthAppointments();
  }

  DateTime _normalizeDate(DateTime d) => DateTime(d.year, d.month, d.day);

  Future<void> _loadMonthAppointments() async {
    setState(() => _isLoading = true);
    try {
      final appointments = await _repo.getAppointments(
        year: _focusedDay.year,
        month: _focusedDay.month,
      );

      final events = <DateTime, List<AppointmentModel>>{};
      for (final apt in appointments) {
        final key = _normalizeDate(apt.appointmentDate);
        events.putIfAbsent(key, () => []).add(apt);
      }

      setState(() {
        _events = events;
        _selectedDayAppointments = events[_normalizeDate(_selectedDay)] ?? [];
      });
    } catch (_) {
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : SafeArea(
        child: Column(
          children: [
            // ─── Header ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'calendar'.tr,
                    style: AppTextStyles.displaySmall.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await Get.toNamed(AppRoutes.addAppointment);
                      _loadMonthAppointments();
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.primaryDark.withValues(alpha: 0.3)
                            : AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        color: isDark
                            ? AppColors.primaryLight
                            : AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ─── Calendar ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TableCalendar<AppointmentModel>(
                firstDay: DateTime(2020),
                lastDay: DateTime(2030),
                focusedDay: _focusedDay,
                selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
                calendarFormat: _calendarFormat,
                eventLoader: (day) => _events[_normalizeDate(day)] ?? [],
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                    _selectedDayAppointments =
                        _events[_normalizeDate(selected)] ?? [];
                  });
                },
                onPageChanged: (focused) {
                  _focusedDay = focused;
                  _loadMonthAppointments();
                },
                onFormatChanged: (format) {
                  setState(() => _calendarFormat = format);
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: isDark ? AppColors.accentLight : AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  markerSize: 6,
                  markersMaxCount: 3,
                  outsideDaysVisible: false,
                  weekendTextStyle: TextStyle(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: AppTextStyles.headingSmall.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left_rounded,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right_rounded,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: AppTextStyles.labelSmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                  ),
                  weekendStyle: AppTextStyles.labelSmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Divider(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),

            // ─── Selected Day Appointments ────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'appointments_on'.tr.replaceAll(
                    '@date',
                    Formatters.dateShortEn(_selectedDay),
                  ),
                  style: AppTextStyles.labelLarge.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
              ),
            ),

            // ─── Appointment List ──────────────────────────
            Expanded(
              child: _selectedDayAppointments.isEmpty
                  ? Center(
                      child: Text(
                        'no_appointments'.tr,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isDark
                              ? AppColors.darkTextTertiary
                              : AppColors.lightTextTertiary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                      itemCount: _selectedDayAppointments.length,
                      itemBuilder: (context, index) {
                        final apt = _selectedDayAppointments[index];
                        return _buildAppointmentTile(apt, isDark);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentTile(AppointmentModel apt, bool isDark) {
    Color statusColor;
    switch (apt.status) {
      case 'completed':
        statusColor = AppColors.success;
        break;
      case 'no_show':
        statusColor = AppColors.error;
        break;
      default:
        statusColor = AppColors.info;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppCard(
        onTap: () =>
            Get.toNamed(AppRoutes.patientDetail, arguments: apt.patientId),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apt.patientName ?? 'Unknown',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  if (apt.notes != null && apt.notes!.isNotEmpty)
                    Text(
                      apt.notes!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            // Status actions
            if (apt.isScheduled) ...[
              IconButton(
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 22,
                ),
                tooltip: 'mark_completed'.tr,
                onPressed: () => _updateStatus(apt.id, 'completed'),
              ),
              IconButton(
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.error,
                  size: 22,
                ),
                tooltip: 'mark_no_show'.tr,
                onPressed: () => _updateStatus(apt.id, 'no_show'),
              ),
            ] else
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  apt.status.tr,
                  style: AppTextStyles.labelSmall.copyWith(color: statusColor),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateStatus(String id, String status) async {
    try {
      await _repo.updateAppointmentStatus(id, status);
      Get.snackbar(
        'success'.tr,
        'appointment_updated'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      await _loadMonthAppointments();
    } catch (_) {
      Get.snackbar(
        'error'.tr,
        'something_went_wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
