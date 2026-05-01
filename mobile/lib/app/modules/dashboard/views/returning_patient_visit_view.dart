import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/palmer_tooth_chart.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/patient_model.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../data/providers/supabase_provider.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

/// Multi-step flow: Pick existing patient → Add Treatment → Schedule Follow-up (optional).
class ReturningPatientVisitView extends StatefulWidget {
  const ReturningPatientVisitView({super.key});

  @override
  State<ReturningPatientVisitView> createState() =>
      _ReturningPatientVisitViewState();
}

class _ReturningPatientVisitViewState extends State<ReturningPatientVisitView> {
  final _repo = AppRepository();
  int _currentStep = 0;
  bool _isSubmitting = false;

  // Step 1 — Select Patient
  PatientModel? _selectedPatient;
  List<PatientModel> _patients = [];
  List<PatientModel> _filtered = [];
  final _searchCtrl = TextEditingController();
  bool _loadingPatients = true;

  // Step 2 — Treatment
  final _treatmentFormKey = GlobalKey<FormState>();
  final _procedureCtrl = TextEditingController();
  final _totalCostCtrl = TextEditingController();
  final _techCostCtrl = TextEditingController();
  final _treatmentNotesCtrl = TextEditingController();
  DateTime _treatmentDate = DateTime.now();
  final List<String> _selectedTeeth = [];

  // Step 3 — Appointment (optional)
  DateTime _appointmentDate = DateTime.now().add(const Duration(days: 7));
  final _aptNotesCtrl = TextEditingController();
  bool _scheduleAppointment = true;

  @override
  void initState() {
    super.initState();
    _loadPatients();
    _searchCtrl.addListener(_onSearch);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _procedureCtrl.dispose();
    _totalCostCtrl.dispose();
    _techCostCtrl.dispose();
    _treatmentNotesCtrl.dispose();
    _aptNotesCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadPatients() async {
    final patients = await _repo.getPatients();
    if (!mounted) return;
    setState(() {
      _patients = patients;
      _filtered = patients;
      _loadingPatients = false;
    });
  }

  void _onSearch() {
    final q = _searchCtrl.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = _patients;
      } else {
        _filtered = _patients
            .where((p) =>
                p.fullName.toLowerCase().contains(q) ||
                p.phone.contains(q))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('returning_patient_visit'.tr),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stepper(
        currentStep: _currentStep,
        type: StepperType.vertical,
        physics: const BouncingScrollPhysics(),
        controlsBuilder: (context, details) {
          // Step 0 has no continue — selecting a patient auto-advances
          if (_currentStep == 0) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                if (_currentStep < 2)
                  Expanded(
                    child: AppButton(
                      label: 'next'.tr,
                      isLoading: _isSubmitting,
                      icon: Icons.arrow_forward_rounded,
                      onPressed: _onStepContinue,
                    ),
                  )
                else
                  Expanded(
                    child: AppButton(
                      label: 'done'.tr,
                      isLoading: _isSubmitting,
                      icon: Icons.check_rounded,
                      onPressed: _onStepContinue,
                    ),
                  ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => setState(() => _currentStep--),
                  child: Text('back'.tr),
                ),
              ],
            ),
          );
        },
        onStepTapped: (step) {
          if (step < _currentStep) setState(() => _currentStep = step);
        },
        steps: [
          Step(
            title: Text('select_patient'.tr),
            subtitle: _selectedPatient != null
                ? Text(_selectedPatient!.fullName)
                : null,
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: _buildPatientSelector(isDark),
          ),
          Step(
            title: Text('add_treatment'.tr),
            subtitle: _currentStep > 1 ? Text(_procedureCtrl.text) : null,
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: _buildTreatmentStep(isDark),
          ),
          Step(
            title: Text('next_appointment'.tr),
            subtitle: Text('optional'.tr),
            isActive: _currentStep >= 2,
            content: _buildAppointmentStep(isDark),
          ),
        ],
      ),
    );
  }

  // ─── Patient Selector ────────────────────────────────────────────

  Widget _buildPatientSelector(bool isDark) {
    if (_loadingPatients) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child:
            Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    return Column(
      children: [
        AppTextField(
          controller: _searchCtrl,
          hint: 'search_patients'.tr,
          prefixIcon: Icons.search_rounded,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 260,
          child: _filtered.isEmpty
              ? Center(
                  child: Text('no_patients'.tr,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.lightTextTertiary,
                      )))
              : ListView.builder(
                  itemCount: _filtered.length,
                  itemBuilder: (context, index) {
                    final p = _filtered[index];
                    final isSelected = _selectedPatient?.id == p.id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: AppCard(
                        onTap: () {
                          setState(() {
                            _selectedPatient = p;
                            _currentStep = 1;
                          });
                        },
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : (isDark
                                        ? AppColors.primaryDark
                                            .withValues(alpha: 0.3)
                                        : AppColors.primarySurface),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  p.fullName[0].toUpperCase(),
                                  style: AppTextStyles.headingSmall.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : (isDark
                                            ? AppColors.primaryLight
                                            : AppColors.primary),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.fullName,
                                    style: AppTextStyles.labelMedium.copyWith(
                                      color: isDark
                                          ? AppColors.darkText
                                          : AppColors.lightText,
                                    ),
                                  ),
                                  Text(
                                    p.phone,
                                    style: AppTextStyles.caption.copyWith(
                                      color: isDark
                                          ? AppColors.darkTextTertiary
                                          : AppColors.lightTextTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_circle_rounded,
                                  color: AppColors.primary, size: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ─── Treatment Step ──────────────────────────────────────────────

  Widget _buildTreatmentStep(bool isDark) {
    return Form(
      key: _treatmentFormKey,
      child: Column(
        children: [
          AppTextField(
            controller: _procedureCtrl,
            label: 'procedure_type'.tr,
            hint: 'procedure_type_hint'.tr,
            prefixIcon: Icons.medical_services_outlined,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'required_field'.tr
                : null,
          ),
          const SizedBox(height: 14),

          // Tooth numbers
          Text('tooth_numbers'.tr, style: AppTextStyles.labelMedium),
          const SizedBox(height: 4),
          Text('select_teeth'.tr,
              style: AppTextStyles.caption.copyWith(
                color: isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
              )),
          const SizedBox(height: 8),
          PalmerToothChart(
            selectedTeeth: _selectedTeeth.toSet(),
            onChanged: (v) => setState(() {
              _selectedTeeth.clear();
              _selectedTeeth.addAll(v);
            }),
            isDark: isDark,
          ),
          if (_selectedTeeth.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: _selectedTeeth
                  .map((t) => Chip(
                        label: Text(t),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () =>
                            setState(() => _selectedTeeth.remove(t)),
                      ))
                  .toList(),
            ),
          ],
          const SizedBox(height: 14),

          AppTextField(
            controller: _totalCostCtrl,
            label: 'treatment_cost'.tr,
            hint: '0',
            prefixIcon: Icons.payments_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (v) => Validators.amount(v, allowZero: true),
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _techCostCtrl,
            label: 'technician_cost'.tr,
            hint: 'technician_cost_hint'.tr,
            prefixIcon: Icons.engineering_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _treatmentDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => _treatmentDate = picked);
            },
            child: AbsorbPointer(
              child: AppTextField(
                controller: TextEditingController(
                    text: Formatters.dateShortEn(_treatmentDate)),
                label: 'treatment_date'.tr,
                prefixIcon: Icons.calendar_today_outlined,
              ),
            ),
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _treatmentNotesCtrl,
            label: '${'notes'.tr} (${'optional'.tr})',
            hint: 'notes'.tr,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  // ─── Tooth Grid ──────────────────────────────────────────────────




  // ─── Appointment Step ────────────────────────────────────────────

  Widget _buildAppointmentStep(bool isDark) {
    return Column(
      children: [
        SwitchListTile(
          value: _scheduleAppointment,
          onChanged: (v) => setState(() => _scheduleAppointment = v),
          title: Text('schedule_follow_up'.tr,
              style: AppTextStyles.labelMedium),
          activeThumbColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
        ),
        if (_scheduleAppointment) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _appointmentDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => _appointmentDate = picked);
            },
            child: AbsorbPointer(
              child: AppTextField(
                controller: TextEditingController(
                    text: Formatters.dateShortEn(_appointmentDate)),
                label: 'appointment_date'.tr,
                prefixIcon: Icons.calendar_month_outlined,
              ),
            ),
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _aptNotesCtrl,
            label: '${'appointment_notes'.tr} (${'optional'.tr})',
            hint: 'notes'.tr,
            maxLines: 2,
          ),
        ],
      ],
    );
  }

  // ─── Step Navigation ─────────────────────────────────────────────

  Future<void> _onStepContinue() async {
    switch (_currentStep) {
      case 0:
        break;
      case 1:
        if (!(_treatmentFormKey.currentState?.validate() ?? false)) return;
        await _createTreatment();
        break;
      case 2:
        await _finishFlow();
        break;
    }
  }

  Future<void> _createTreatment() async {
    if (_selectedPatient == null) return;
    final totalCost = double.tryParse(_totalCostCtrl.text.trim()) ?? 0;
    final techCost = double.tryParse(_techCostCtrl.text.trim()) ?? 0;

    if (techCost > totalCost) {
      Get.snackbar('error'.tr, 'technician_cost_exceeds'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final treatment = await _repo.createTreatment({
        'patient_id': _selectedPatient!.id,
        'dentist_id': SupabaseProvider.userId,
        'procedure_type': _procedureCtrl.text.trim(),
        'tooth_numbers': _selectedTeeth,
        'total_cost': totalCost,
        'technician_cost': techCost,
        'treatment_date': Formatters.dateIso(_treatmentDate),
        'notes': _treatmentNotesCtrl.text.trim().isEmpty
            ? null
            : _treatmentNotesCtrl.text.trim(),
      });

      // Auto-create a "today" appointment marked as completed so the patient
      // appears in today's schedule with the checkbox checked.
      await _repo.createAppointment({
        'patient_id': _selectedPatient!.id,
        'dentist_id': SupabaseProvider.userId,
        'treatment_id': treatment.id,
        'appointment_date': Formatters.dateIso(_treatmentDate),
        'status': 'completed',
        'notes': _procedureCtrl.text.trim(),
      });

      setState(() => _currentStep = 2);
    } catch (_) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  Future<void> _finishFlow() async {
    setState(() => _isSubmitting = true);
    try {
      if (_scheduleAppointment && _selectedPatient != null) {
        await _repo.createAppointment({
          'patient_id': _selectedPatient!.id,
          'dentist_id': SupabaseProvider.userId,
          'appointment_date': Formatters.dateIso(_appointmentDate),
          'notes': _aptNotesCtrl.text.trim().isEmpty
              ? null
              : _aptNotesCtrl.text.trim(),
        });
      }

      Get.back();
      Get.snackbar('success'.tr, 'treatment_added'.tr,
          snackPosition: SnackPosition.BOTTOM);

      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().refreshDashboard();
      }
    } catch (_) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
