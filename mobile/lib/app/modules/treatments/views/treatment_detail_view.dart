import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/payment_sheet.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/treatment_model.dart';
import '../../../data/models/payment_model.dart';
import '../../../data/repositories/app_repository.dart';

/// Treatment detail view with cost breakdown and payment history.
class TreatmentDetailView extends StatefulWidget {
  const TreatmentDetailView({super.key});

  @override
  State<TreatmentDetailView> createState() => _TreatmentDetailViewState();
}

class _TreatmentDetailViewState extends State<TreatmentDetailView> {
  final _repo = AppRepository();
  TreatmentModel? _treatment;
  List<PaymentModel> _payments = [];
  bool _isLoading = true;
  double _revenuePercentage = 100;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final id = Get.arguments is String ? Get.arguments as String : null;
    if (id == null) return;

    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        _repo.getTreatment(id),
        _repo.getPayments(treatmentId: id),
        _repo.getProfile(),
      ]);
      setState(() {
        _treatment = results[0] as TreatmentModel?;
        _payments = results[1] as List<PaymentModel>;
        final profile = results[2];
        if (profile != null) {
          _revenuePercentage = (profile as dynamic).revenuePercentage;
        }
      });
    } catch (_) {
      Get.snackbar(
        'error'.tr,
        'something_went_wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (_treatment == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('no_data'.tr)),
      );
    }

    final t = _treatment!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.procedureType),
        actions: [
          if (!t.isCompleted)
            TextButton.icon(
              onPressed: () => _markComplete(t),
              icon: const Icon(Icons.check_circle_outline, size: 18),
              label: Text('mark_complete'.tr),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ─── Status & Date ─────────────────────────────
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: t.isCompleted
                        ? AppColors.success.withValues(alpha: 0.12)
                        : AppColors.warning.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    t.isCompleted ? 'completed'.tr : 'in_progress'.tr,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: t.isCompleted
                          ? AppColors.success
                          : AppColors.warning,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  Formatters.dateShortEn(t.treatmentDate),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ─── Cost Breakdown ────────────────────────────
            GradientCard(
              gradient: AppColors.primaryGradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'cost_breakdown'.tr,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _costRow('total_cost'.tr, t.totalCost, Colors.white),
                  _costRow(
                    'technician_cost'.tr,
                    -t.technicianCost,
                    Colors.white70,
                  ),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.2),
                    height: 16,
                  ),
                  _costRow('net_revenue'.tr, t.netRevenue, Colors.white),
                  _costRow(
                    '${'dentist_share'.tr} (${Formatters.percentage(_revenuePercentage)})',
                    t.dentistShare(_revenuePercentage),
                    AppColors.accentLight,
                  ),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.2),
                    height: 16,
                  ),
                  _costRow(
                    'amount_paid'.tr,
                    t.amountPaid,
                    AppColors.successLight,
                  ),
                  _costRow(
                    'remaining_balance'.tr,
                    t.remainingBalance,
                    t.remainingBalance > 0
                        ? AppColors.warningLight
                        : AppColors.successLight,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ─── Tooth Numbers ─────────────────────────────
            if (t.toothNumbers.isNotEmpty) ...[
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.masks_outlined,
                      size: 20,
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: t.toothNumbers
                            .map(
                              (n) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.darkCardElevated
                                      : AppColors.lightCardElevated,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '#$n',
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: isDark
                                        ? AppColors.darkText
                                        : AppColors.lightText,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // ─── Notes ─────────────────────────────────────
            if (t.notes != null && t.notes!.isNotEmpty) ...[
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.note_outlined,
                      size: 20,
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t.notes!,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // ─── Payment History ───────────────────────────
            _buildPaymentSection(isDark, t),
          ],
        ),
      ),
      bottomNavigationBar: t.remainingBalance > 0
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AppButton(
                  label: 'record_payment'.tr,
                  icon: Icons.payments_outlined,
                  onPressed: () => _showPaymentSheet(t),
                ),
              ),
            )
          : null,
    );
  }

  Widget _costRow(String label, double amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: color.withValues(alpha: 0.8),
            ),
          ),
          Text(
            Formatters.currency(amount),
            style: AppTextStyles.labelLarge.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(bool isDark, TreatmentModel t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.receipt_long_rounded,
              size: 20,
              color: isDark ? AppColors.primaryLight : AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'payment_history'.tr,
              style: AppTextStyles.headingSmall.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_payments.isEmpty)
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                'no_payments'.tr,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                ),
              ),
            ),
          )
        else
          ...(_payments.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.success,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Formatters.currency(p.amount),
                            style: AppTextStyles.labelLarge.copyWith(
                              color: isDark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                          ),
                          Text(
                            '${p.paymentMethod.tr} • ${Formatters.dateShortEn(p.paymentDate)}',
                            style: AppTextStyles.caption.copyWith(
                              color: isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      ],
    );
  }

  void _showPaymentSheet(TreatmentModel t) {
    PaymentSheet.show(
      context: context,
      treatment: t,
      onPaymentRecorded: () => _loadData(),
    );
  }

  Future<void> _markComplete(TreatmentModel t) async {
    if (t.remainingBalance > 0) {
      final confirm = await Get.dialog<bool>(
        AlertDialog(
          title: Text('warning'.tr),
          content: Text(
            'complete_with_balance'.tr.replaceAll(
              '@amount',
              Formatters.currency(t.remainingBalance),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text('confirm'.tr),
            ),
          ],
        ),
      );
      if (confirm != true) return;
    }
    try {
      await _repo.updateTreatment(t.id, {'status': 'completed'});
      Get.snackbar(
        'success'.tr,
        'treatment_completed'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      await _loadData();
    } catch (_) {
      Get.snackbar(
        'error'.tr,
        'something_went_wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
