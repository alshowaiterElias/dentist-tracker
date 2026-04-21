import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/repositories/app_repository.dart';

/// Monthly reports with financial breakdown.
class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => ReportsViewState();
}

class ReportsViewState extends State<ReportsView> {
  final _repo = AppRepository();
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  Map<String, dynamic> _report = {};
  double _revenuePercentage = 100;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  /// Called by HomeView when this tab becomes active
  void refreshData() {
    if (!mounted) return;
    _loadReport();
  }

  Future<void> _loadReport() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        _repo.getMonthlyReport(_selectedYear, _selectedMonth),
        _repo.getProfile(),
      ]);
      if (!mounted) return;
      setState(() {
        _report = results[0] as Map<String, dynamic>;
        final profile = results[1];
        if (profile != null) {
          _revenuePercentage = (profile as dynamic).revenuePercentage;
        }
      });
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ─── Header ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                'monthly_reports'.tr,
                style: AppTextStyles.displaySmall.copyWith(
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ─── Month Selector ────────────────────────────
            _buildMonthSelector(isDark),
            const SizedBox(height: 16),

            // ─── Report Content ────────────────────────────
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : _report.isEmpty
                      ? Center(
                          child: Text('no_report_data'.tr,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isDark
                                    ? AppColors.darkTextTertiary
                                    : AppColors.lightTextTertiary,
                              )))
                      : _buildReportContent(isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSelector(bool isDark) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    return Column(
      children: [
        // Year navigation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded),
                onPressed: () {
                  setState(() => _selectedYear--);
                  _loadReport();
                },
              ),
              Text(
                '$_selectedYear',
                style: AppTextStyles.headingMedium.copyWith(
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded),
                onPressed: _selectedYear < DateTime.now().year
                    ? () {
                        setState(() => _selectedYear++);
                        _loadReport();
                      }
                    : null,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Month grid
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 12,
            itemBuilder: (context, index) {
              final isSelected = _selectedMonth == index + 1;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedMonth = index + 1);
                  _loadReport();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? AppColors.primaryLight : AppColors.primary)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: isSelected
                        ? null
                        : Border.all(
                            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    months[index],
                    style: AppTextStyles.labelSmall.copyWith(
                      color: isSelected
                          ? Colors.white
                          : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReportContent(bool isDark) {
    final totalRevenue = (_report['total_revenue'] as num?)?.toDouble() ?? 0;
    final techCost = (_report['total_technician_cost'] as num?)?.toDouble() ?? 0;
    final netRevenue = (_report['net_revenue'] as num?)?.toDouble() ?? 0;
    final collected = (_report['amount_collected'] as num?)?.toDouble() ?? 0;
    final dentistEarnings = netRevenue * (_revenuePercentage / 100);
    final treatments = (_report['total_treatments'] as num?)?.toInt() ?? 0;
    final completed = (_report['completed_treatments'] as num?)?.toInt() ?? 0;
    final appointments = (_report['total_appointments'] as num?)?.toInt() ?? 0;
    final noShows = (_report['no_show_count'] as num?)?.toInt() ?? 0;
    final newPatients = (_report['new_patients'] as num?)?.toInt() ?? 0;
    final noShowRate = appointments > 0 ? (noShows / appointments * 100) : 0.0;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      children: [
        // Revenue card
        GradientCard(
          gradient: AppColors.primaryGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('revenue'.tr,
                  style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white.withValues(alpha: 0.85))),
              const SizedBox(height: 16),
              Text(
                Formatters.currency(dentistEarnings),
                style: AppTextStyles.displayMedium.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${'dentist_share'.tr} (${Formatters.percentage(_revenuePercentage)})',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.white.withValues(alpha: 0.2)),
              const SizedBox(height: 8),
              _reportRow('total_revenue'.tr, Formatters.currency(totalRevenue), Colors.white),
              _reportRow('technician_costs'.tr, Formatters.currency(techCost), Colors.white70),
              _reportRow('net_revenue'.tr, Formatters.currency(netRevenue), Colors.white),
              _reportRow('amount_paid'.tr, Formatters.currency(collected), AppColors.successLight),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Stats grid
        Row(
          children: [
            Expanded(child: _statCard('completed_treatments'.tr, '$completed/$treatments',
                Icons.medical_services_outlined, AppColors.primary, isDark)),
            const SizedBox(width: 10),
            Expanded(child: _statCard('appointment_count'.tr, '$appointments',
                Icons.calendar_month_outlined, AppColors.info, isDark)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _statCard('no_show_rate'.tr, '${noShowRate.toStringAsFixed(1)}%',
                Icons.person_off_outlined, AppColors.error, isDark)),
            const SizedBox(width: 10),
            Expanded(child: _statCard('patients'.tr, '+$newPatients',
                Icons.person_add_outlined, AppColors.success, isDark)),
          ],
        ),
        const SizedBox(height: 16),

        // Outstanding
        AppCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('outstanding_balances'.tr,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        )),
                    Text(
                      Formatters.currency(totalRevenue - collected),
                      style: AppTextStyles.headingMedium.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reportRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall.copyWith(color: color.withValues(alpha: 0.8))),
          Text(value, style: AppTextStyles.labelMedium.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color, bool isDark) {
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
          Text(value, style: AppTextStyles.headingMedium.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
          )),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.caption.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
          )),
        ],
      ),
    );
  }
}
