import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../utils/formatters.dart';
import '../utils/validators.dart';
import '../../data/models/treatment_model.dart';
import '../../data/repositories/app_repository.dart';
import '../../data/providers/supabase_provider.dart';

/// Shared payment recording bottom sheet.
/// Can be called from TreatmentDetailView, Dashboard table, etc.
class PaymentSheet {
  PaymentSheet._();

  /// Show the payment recording sheet for a given treatment.
  ///
  /// [onPaymentRecorded] is called after a successful payment so the caller
  /// can refresh its own state (e.g. reload treatment, reload daily visits).
  static void show({
    required BuildContext context,
    required TreatmentModel treatment,
    required VoidCallback onPaymentRecorded,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final amountCtrl = TextEditingController();
    final notesCtrl = TextEditingController();
    final selectedMethod = 'cash'.obs;
    final isSubmitting = false.obs;
    final repo = AppRepository();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text('record_payment'.tr, style: AppTextStyles.headingMedium),
              const SizedBox(height: 4),
              Text(
                '${'remaining_balance'.tr}: ${Formatters.currency(treatment.remainingBalance)}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: amountCtrl,
                label: 'payment_amount'.tr,
                hint: '0',
                prefixIcon: Icons.payments_outlined,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) => Validators.amount(v, allowZero: false),
              ),
              const SizedBox(height: 16),
              Text('payment_method'.tr, style: AppTextStyles.labelMedium),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: ['cash', 'bank_transfer', 'other'].map((m) {
                    final selected = selectedMethod.value == m;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => selectedMethod.value = m,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary.withValues(alpha: 0.12)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.lightBorder,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              m.tr,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: notesCtrl,
                label: '${'payment_notes'.tr} (${'optional'.tr})',
                hint: 'notes'.tr,
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              Obx(
                () => AppButton(
                  label: 'save'.tr,
                  isLoading: isSubmitting.value,
                  icon: Icons.check_rounded,
                  onPressed: () async {
                    final amount =
                        double.tryParse(amountCtrl.text.trim()) ?? 0;
                    if (amount <= 0) {
                      Get.snackbar(
                        'error'.tr,
                        'amount_must_be_positive'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                    if (amount > treatment.remainingBalance) {
                      final confirm = await Get.dialog<bool>(
                        AlertDialog(
                          title: Text('warning'.tr),
                          content: Text('overpayment_warning'.tr),
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
                    isSubmitting.value = true;
                    try {
                      await repo.createPayment({
                        'treatment_id': treatment.id,
                        'dentist_id': SupabaseProvider.userId,
                        'amount': amount,
                        'payment_method': selectedMethod.value,
                        'notes': notesCtrl.text.trim().isEmpty
                            ? null
                            : notesCtrl.text.trim(),
                        'payment_date': Formatters.dateIso(DateTime.now()),
                      });
                      // Update local treatment's amount_paid immediately
                      final newPaid = (treatment.amountPaid + amount)
                          .clamp(0, double.infinity);
                      await repo.updateTreatment(
                          treatment.id, {'amount_paid': newPaid});
                      Get.back();
                      Get.snackbar(
                        'success'.tr,
                        'payment_recorded'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      onPaymentRecorded();
                    } catch (_) {
                      Get.snackbar(
                        'error'.tr,
                        'something_went_wrong'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } finally {
                      isSubmitting.value = false;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
