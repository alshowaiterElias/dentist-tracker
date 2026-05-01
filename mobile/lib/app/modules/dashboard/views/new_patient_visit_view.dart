import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/palmer_tooth_chart.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../data/providers/supabase_provider.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../patients/controllers/patient_list_controller.dart';

/// Multi-step flow: Register Patient → Add Treatment → Schedule Appointment (optional).
class NewPatientVisitView extends StatefulWidget {
  const NewPatientVisitView({super.key});

  @override
  State<NewPatientVisitView> createState() => _NewPatientVisitViewState();
}

class _NewPatientVisitViewState extends State<NewPatientVisitView> {
  final _repo = AppRepository();
  int _currentStep = 0;
  bool _isSubmitting = false;

  // Step 1 — Patient
  final _patientFormKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _medicalCtrl = TextEditingController();
  final _conditionCtrl = TextEditingController();

  // Step 2 — Treatment
  final _treatmentFormKey = GlobalKey<FormState>();
  final _procedureCtrl = TextEditingController();
  final _totalCostCtrl = TextEditingController();
  final _techCostCtrl = TextEditingController();
  final _treatmentNotesCtrl = TextEditingController();
  DateTime _treatmentDate = DateTime.now();
  final List<String> _selectedTeeth = [];

  // Step 3 — Follow-up Appointment (optional)
  DateTime _appointmentDate = DateTime.now().add(const Duration(days: 7));
  final _aptNotesCtrl = TextEditingController();
  bool _scheduleAppointment = true;

  // Result from step 1
  String? _createdPatientId;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _ageCtrl.dispose();
    _medicalCtrl.dispose();
    _conditionCtrl.dispose();
    _procedureCtrl.dispose();
    _totalCostCtrl.dispose();
    _techCostCtrl.dispose();
    _treatmentNotesCtrl.dispose();
    _aptNotesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('new_patient_visit'.tr),
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
                if (_currentStep > 0) ...[
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => setState(() => _currentStep--),
                    child: Text('back'.tr),
                  ),
                ],
              ],
            ),
          );
        },
        onStepTapped: (step) {
          if (step < _currentStep) setState(() => _currentStep = step);
        },
        steps: [
          Step(
            title: Text('patient_info'.tr),
            subtitle: _currentStep > 0 ? Text(_nameCtrl.text) : null,
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: _buildPatientStep(isDark),
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
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            content: _buildAppointmentStep(isDark),
          ),
        ],
      ),
    );
  }

  // ─── Patient Step ────────────────────────────────────────────────

  Widget _buildPatientStep(bool isDark) {
    return Form(
      key: _patientFormKey,
      child: Column(
        children: [
          AppTextField(
            controller: _nameCtrl,
            label: 'full_name'.tr,
            hint: 'full_name'.tr,
            prefixIcon: Icons.person_outline,
            validator: Validators.name,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _phoneCtrl,
            label: 'phone'.tr,
            hint: '+967 ...',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: Validators.phone,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _ageCtrl,
            label: 'age'.tr,
            hint: 'age'.tr,
            prefixIcon: Icons.cake_outlined,
            keyboardType: TextInputType.number,
            validator: Validators.age,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _medicalCtrl,
            label: 'medical_status'.tr,
            hint: 'e.g., Healthy, Diabetic',
            prefixIcon: Icons.monitor_heart_outlined,
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _conditionCtrl,
            label: 'initial_condition'.tr,
            hint: 'Dental condition...',
            prefixIcon: Icons.medical_information_outlined,
            maxLines: 2,
          ),
        ],
      ),
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
        if (!(_patientFormKey.currentState?.validate() ?? false)) return;
        await _createPatient();
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

  Future<void> _createPatient() async {
    setState(() => _isSubmitting = true);
    try {
      final userId = SupabaseProvider.userId;
      if (userId == null) return;

      final patient = await _repo.createPatient({
        'dentist_id': userId,
        'full_name': _nameCtrl.text.trim(),
        'phone': _phoneCtrl.text.trim(),
        'age': int.tryParse(_ageCtrl.text.trim()),
        'medical_status': _medicalCtrl.text.trim().isEmpty
            ? null
            : _medicalCtrl.text.trim(),
        'condition': _conditionCtrl.text.trim().isEmpty
            ? null
            : _conditionCtrl.text.trim(),
      });
      _createdPatientId = patient.id;
      setState(() => _currentStep = 1);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('idx_patients_phone_dentist') ||
          msg.contains('duplicate')) {
        Get.snackbar('error'.tr,
            'A patient with this phone number already exists.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('error'.tr, 'something_went_wrong'.tr,
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  Future<void> _createTreatment() async {
    if (_createdPatientId == null) return;
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
        'patient_id': _createdPatientId,
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
        'patient_id': _createdPatientId,
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
      // Create optional future follow-up appointment
      if (_scheduleAppointment && _createdPatientId != null) {
        await _repo.createAppointment({
          'patient_id': _createdPatientId,
          'dentist_id': SupabaseProvider.userId,
          'appointment_date': Formatters.dateIso(_appointmentDate),
          'notes': _aptNotesCtrl.text.trim().isEmpty
              ? null
              : _aptNotesCtrl.text.trim(),
        });
      }

      Get.back();
      Get.snackbar('success'.tr, 'patient_added'.tr,
          snackPosition: SnackPosition.BOTTOM);

      // Refresh dashboard + patient list
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().refreshDashboard();
      }
      if (Get.isRegistered<PatientListController>()) {
        Get.find<PatientListController>().loadPatients();
      }
    } catch (_) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
