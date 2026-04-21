import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/providers/supabase_provider.dart';
import '../../../data/repositories/app_repository.dart';
import '../../patients/controllers/patient_detail_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

/// Add treatment form with tooth selection.
class AddTreatmentView extends StatefulWidget {
  const AddTreatmentView({super.key});

  @override
  State<AddTreatmentView> createState() => _AddTreatmentViewState();
}

class _AddTreatmentViewState extends State<AddTreatmentView> {
  final _formKey = GlobalKey<FormState>();
  final _repo = AppRepository();

  final _procedureCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _totalCostCtrl = TextEditingController();
  final _techCostCtrl = TextEditingController(text: '0');

  final _selectedTeeth = <int>{};
  final _isSubmitting = false.obs;
  DateTime _treatmentDate = DateTime.now();

  String? _patientId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      _patientId = args['patientId'] as String?;
    }
  }

  @override
  void dispose() {
    _procedureCtrl.dispose();
    _descriptionCtrl.dispose();
    _notesCtrl.dispose();
    _totalCostCtrl.dispose();
    _techCostCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('add_treatment'.tr),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Procedure Type
              AppTextField(
                controller: _procedureCtrl,
                label: 'procedure_type'.tr,
                hint: 'procedure_type_hint'.tr,
                prefixIcon: Icons.medical_services_outlined,
                validator: (v) => Validators.required(v, 'procedure_type'.tr),
              ),
              const SizedBox(height: 16),

              // Tooth Selection
              Text(
                'tooth_numbers'.tr,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 8),
              _buildToothGrid(isDark),
              if (_selectedTeeth.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: _selectedTeeth.map((n) => Chip(
                    label: Text('#$n'),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => setState(() => _selectedTeeth.remove(n)),
                  )).toList(),
                ),
              ],
              const SizedBox(height: 16),

              // Description
              AppTextField(
                controller: _descriptionCtrl,
                label: '${'description'.tr} (${'optional'.tr})',
                hint: 'Description of the procedure...',
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Cost fields
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _totalCostCtrl,
                      label: 'treatment_cost'.tr,
                      hint: '0',
                      prefixIcon: Icons.payments_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: Validators.amount,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                      controller: _techCostCtrl,
                      label: 'technician_cost'.tr,
                      hint: 'technician_cost_hint'.tr,
                      prefixIcon: Icons.engineering_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Treatment Date
              AppTextField(
                label: 'treatment_date'.tr,
                hint: Formatters.dateShortEn(_treatmentDate),
                prefixIcon: Icons.calendar_today_outlined,
                readOnly: true,
                controller: TextEditingController(
                    text: Formatters.dateShortEn(_treatmentDate)),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _treatmentDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() => _treatmentDate = picked);
                  }
                },
              ),
              const SizedBox(height: 16),

              // Notes
              AppTextField(
                controller: _notesCtrl,
                label: '${'treatment_notes'.tr} (${'optional'.tr})',
                hint: 'notes'.tr,
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              // Submit
              Obx(() => AppButton(
                    label: 'save'.tr,
                    isLoading: _isSubmitting.value,
                    icon: Icons.check_rounded,
                    onPressed: _submit,
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Scrollable tooth grid to prevent overflow
  Widget _buildToothGrid(bool isDark) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Upper jaw label
          Text('Upper', style: AppTextStyles.caption.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
          )),
          const SizedBox(height: 4),
          // Upper teeth: 18-11, 21-28 - scrollable
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(8, (i) => _toothButton(18 - i, isDark)),
                Container(width: 2, height: 30, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                ...List.generate(8, (i) => _toothButton(21 + i, isDark)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          const SizedBox(height: 4),
          // Lower teeth: 48-41, 31-38 - scrollable
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(8, (i) => _toothButton(48 - i, isDark)),
                Container(width: 2, height: 30, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                ...List.generate(8, (i) => _toothButton(31 + i, isDark)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text('Lower', style: AppTextStyles.caption.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
          )),
        ],
      ),
    );
  }

  Widget _toothButton(int number, bool isDark) {
    final isSelected = _selectedTeeth.contains(number);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTeeth.remove(number);
          } else {
            _selectedTeeth.add(number);
          }
        });
      },
      child: Container(
        width: 28,
        height: 30,
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.primaryLight : AppColors.primary)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(
              fontSize: 9,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_patientId == null) return;

    final totalCost = double.tryParse(_totalCostCtrl.text.trim()) ?? 0;
    final techCost = double.tryParse(_techCostCtrl.text.trim()) ?? 0;

    if (techCost > totalCost) {
      Get.snackbar('error'.tr, 'technician_cost_exceeds'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      _isSubmitting.value = true;
      await _repo.createTreatment({
        'patient_id': _patientId,
        'dentist_id': SupabaseProvider.userId,
        'procedure_type': _procedureCtrl.text.trim(),
        'tooth_numbers': _selectedTeeth.toList()..sort(),
        'description': _descriptionCtrl.text.trim().isEmpty
            ? null
            : _descriptionCtrl.text.trim(),
        'notes': _notesCtrl.text.trim().isEmpty
            ? null
            : _notesCtrl.text.trim(),
        'total_cost': totalCost,
        'technician_cost': techCost,
        'treatment_date': Formatters.dateIso(_treatmentDate),
      });

      // Navigate back first — works whether online or offline
      Get.back();
      Get.snackbar('success'.tr, 'treatment_added'.tr,
          snackPosition: SnackPosition.BOTTOM);

      // Refresh in background
      if (Get.isRegistered<PatientDetailController>()) {
        Get.find<PatientDetailController>().loadPatientData();
      }
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().refreshDashboard();
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isSubmitting.value = false;
    }
  }
}
