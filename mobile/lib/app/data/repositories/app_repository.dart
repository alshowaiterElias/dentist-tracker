import '../models/patient_model.dart';
import '../models/treatment_model.dart';
import '../models/payment_model.dart';
import '../models/appointment_model.dart';
import '../models/medication_model.dart';
import '../models/file_model.dart';
import '../models/profile_model.dart';
import '../providers/supabase_provider.dart';

/// Repository layer — all Supabase CRUD operations.
class AppRepository {
  // ─── Profiles ──────────────────────────────────────────────────────

  Future<ProfileModel?> getProfile() async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return null;
    final data = await SupabaseProvider.from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();
    if (data == null) return null;
    return ProfileModel.fromJson(data);
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return;
    await SupabaseProvider.from('profiles').update(updates).eq('id', userId);
  }

  // ─── Patients ──────────────────────────────────────────────────────

  Future<List<PatientModel>> getPatients({String? search}) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    var query = SupabaseProvider.from('patients')
        .select()
        .eq('dentist_id', userId)
        .eq('is_deleted', false);

    if (search != null && search.isNotEmpty) {
      query = query.or('full_name.ilike.%$search%,phone.ilike.%$search%');
    }

    final data = await query.order('created_at', ascending: false);
    return (data as List).map((e) => PatientModel.fromJson(e)).toList();
  }

  Future<PatientModel?> getPatient(String id) async {
    final data = await SupabaseProvider.from('patients')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (data == null) return null;
    return PatientModel.fromJson(data);
  }

  Future<PatientModel> createPatient(Map<String, dynamic> patient) async {
    final data = await SupabaseProvider.from('patients')
        .insert(patient)
        .select()
        .single();
    return PatientModel.fromJson(data);
  }

  Future<void> updatePatient(String id, Map<String, dynamic> updates) async {
    await SupabaseProvider.from('patients').update(updates).eq('id', id);
  }

  Future<void> softDeletePatient(String id) async {
    await SupabaseProvider.from('patients')
        .update({'is_deleted': true}).eq('id', id);
  }

  Future<Map<String, dynamic>> getPatientFinancials(String patientId) async {
    final result = await SupabaseProvider.rpc(
      'get_patient_financials',
      params: {'p_patient_id': patientId},
    );
    return result as Map<String, dynamic>;
  }

  // ─── Treatments ────────────────────────────────────────────────────

  Future<List<TreatmentModel>> getTreatments({String? patientId}) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    var query = SupabaseProvider.from('treatments')
        .select('*, patients(full_name)')
        .eq('dentist_id', userId);

    if (patientId != null) {
      query = query.eq('patient_id', patientId);
    }

    final data = await query.order('treatment_date', ascending: false);
    return (data as List).map((e) => TreatmentModel.fromJson(e)).toList();
  }

  Future<TreatmentModel?> getTreatment(String id) async {
    final data = await SupabaseProvider.from('treatments')
        .select('*, patients(full_name)')
        .eq('id', id)
        .maybeSingle();
    if (data == null) return null;
    return TreatmentModel.fromJson(data);
  }

  Future<TreatmentModel> createTreatment(Map<String, dynamic> treatment) async {
    final data = await SupabaseProvider.from('treatments')
        .insert(treatment)
        .select()
        .single();
    return TreatmentModel.fromJson(data);
  }

  Future<void> updateTreatment(String id, Map<String, dynamic> updates) async {
    await SupabaseProvider.from('treatments').update(updates).eq('id', id);
  }

  // ─── Payments ──────────────────────────────────────────────────────

  Future<List<PaymentModel>> getPayments({
    String? treatmentId,
    String? dentistId,
  }) async {
    final uid = dentistId ?? SupabaseProvider.userId;
    if (uid == null) return [];

    var query = SupabaseProvider.from('payments')
        .select()
        .eq('dentist_id', uid);

    if (treatmentId != null) {
      query = query.eq('treatment_id', treatmentId);
    }

    final data = await query.order('payment_date', ascending: false);
    return (data as List).map((e) => PaymentModel.fromJson(e)).toList();
  }

  Future<PaymentModel> createPayment(Map<String, dynamic> payment) async {
    final data = await SupabaseProvider.from('payments')
        .insert(payment)
        .select()
        .single();
    return PaymentModel.fromJson(data);
  }

  // ─── Appointments ──────────────────────────────────────────────────

  Future<List<AppointmentModel>> getAppointments({
    DateTime? date,
    String? patientId,
    int? year,
    int? month,
  }) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    var query = SupabaseProvider.from('appointments')
        .select('*, patients(full_name, phone)')
        .eq('dentist_id', userId);

    if (date != null) {
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      query = query.eq('appointment_date', dateStr);
    }

    if (patientId != null) {
      query = query.eq('patient_id', patientId);
    }

    if (year != null && month != null) {
      final start = '$year-${month.toString().padLeft(2, '0')}-01';
      final endMonth = month == 12 ? 1 : month + 1;
      final endYear = month == 12 ? year + 1 : year;
      final end = '$endYear-${endMonth.toString().padLeft(2, '0')}-01';
      query = query.gte('appointment_date', start).lt('appointment_date', end);
    }

    final data = await query.order('appointment_date', ascending: true);
    return (data as List).map((e) => AppointmentModel.fromJson(e)).toList();
  }

  Future<AppointmentModel> createAppointment(Map<String, dynamic> apt) async {
    final data = await SupabaseProvider.from('appointments')
        .insert(apt)
        .select('*, patients(full_name, phone)')
        .single();
    return AppointmentModel.fromJson(data);
  }

  Future<void> updateAppointmentStatus(String id, String status) async {
    await SupabaseProvider.from('appointments')
        .update({'status': status}).eq('id', id);
  }

  Future<void> deleteAppointment(String id) async {
    await SupabaseProvider.from('appointments').delete().eq('id', id);
  }

  // ─── Medications ───────────────────────────────────────────────────

  Future<List<MedicationModel>> getMedications({
    String? patientId,
    String? treatmentId,
  }) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    var query = SupabaseProvider.from('medications')
        .select()
        .eq('dentist_id', userId);

    if (patientId != null) query = query.eq('patient_id', patientId);
    if (treatmentId != null) query = query.eq('treatment_id', treatmentId);

    final data = await query.order('prescribed_date', ascending: false);
    return (data as List).map((e) => MedicationModel.fromJson(e)).toList();
  }

  Future<MedicationModel> createMedication(Map<String, dynamic> med) async {
    final data = await SupabaseProvider.from('medications')
        .insert(med)
        .select()
        .single();
    return MedicationModel.fromJson(data);
  }

  Future<void> deleteMedication(String id) async {
    await SupabaseProvider.from('medications').delete().eq('id', id);
  }

  // ─── Files ─────────────────────────────────────────────────────────

  Future<List<FileModel>> getFiles({
    String? patientId,
    String? treatmentId,
  }) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    var query = SupabaseProvider.from('files')
        .select()
        .eq('dentist_id', userId);

    if (patientId != null) query = query.eq('patient_id', patientId);
    if (treatmentId != null) query = query.eq('treatment_id', treatmentId);

    final data = await query.order('uploaded_at', ascending: false);
    return (data as List).map((e) => FileModel.fromJson(e)).toList();
  }

  Future<FileModel> createFileRecord(Map<String, dynamic> file) async {
    final data = await SupabaseProvider.from('files')
        .insert(file)
        .select()
        .single();
    return FileModel.fromJson(data);
  }

  Future<void> deleteFile(String id, String storagePath) async {
    await SupabaseProvider.storage.remove([storagePath]);
    await SupabaseProvider.from('files').delete().eq('id', id);
  }

  // ─── Reports ───────────────────────────────────────────────────────

  Future<Map<String, dynamic>> getFinancialSummary() async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return {};
    final result = await SupabaseProvider.rpc(
      'get_financial_summary',
      params: {'p_dentist_id': userId},
    );
    return result as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getMonthlyReport(int year, int month) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return {};
    final result = await SupabaseProvider.rpc(
      'get_monthly_report',
      params: {
        'p_dentist_id': userId,
        'p_year': year,
        'p_month': month,
      },
    );
    return result as Map<String, dynamic>;
  }
}
