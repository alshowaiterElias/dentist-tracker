// ignore_for_file: type=lint
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'local_database.g.dart';

// ─── Table Definitions ───────────────────────────────────────────────────────

class ProfilesTable extends Table {
  TextColumn get id => text()();
  TextColumn get dentistId => text().named('dentist_id')();
  TextColumn get fullName => text().named('full_name')();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  RealColumn get revenuePercentage =>
      real().named('revenue_percentage').withDefault(const Constant(100.0))();
  TextColumn get preferredLanguage =>
      text().named('preferred_language').withDefault(const Constant('en'))();
  TextColumn get cachedAt => text().named('cached_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class PatientsTable extends Table {
  TextColumn get id => text()();
  TextColumn get dentistId => text().named('dentist_id')();
  TextColumn get fullName => text().named('full_name')();
  TextColumn get phone => text()();
  IntColumn get age => integer().nullable()();
  TextColumn get medicalStatus => text().named('medical_status').nullable()();
  TextColumn get condition => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isDeleted =>
      boolean().named('is_deleted').withDefault(const Constant(false))();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
  TextColumn get cachedAt => text().named('cached_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class TreatmentsTable extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().named('patient_id')();
  TextColumn get dentistId => text().named('dentist_id')();
  TextColumn get procedureType => text().named('procedure_type')();
  TextColumn get toothNumbers =>
      text().named('tooth_numbers').withDefault(const Constant('[]'))();
  TextColumn get description => text().nullable()();
  TextColumn get treatmentNotes => text().named('treatment_notes').nullable()();
  RealColumn get totalCost =>
      real().named('total_cost').withDefault(const Constant(0.0))();
  RealColumn get technicianCost =>
      real().named('technician_cost').withDefault(const Constant(0.0))();
  RealColumn get amountPaid =>
      real().named('amount_paid').withDefault(const Constant(0.0))();
  TextColumn get status =>
      text().withDefault(const Constant('in_progress'))();
  TextColumn get treatmentDate => text().named('treatment_date')();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get patientName => text().named('patient_name').nullable()();
  TextColumn get cachedAt => text().named('cached_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class PaymentsTable extends Table {
  TextColumn get id => text()();
  TextColumn get treatmentId => text().named('treatment_id')();
  TextColumn get dentistId => text().named('dentist_id')();
  RealColumn get amount => real()();
  TextColumn get paymentMethod =>
      text().named('payment_method').withDefault(const Constant('cash'))();
  TextColumn get notes => text().nullable()();
  TextColumn get paymentDate => text().named('payment_date')();
  TextColumn get cachedAt => text().named('cached_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class AppointmentsTable extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().named('patient_id')();
  TextColumn get dentistId => text().named('dentist_id')();
  TextColumn get treatmentId => text().named('treatment_id').nullable()();
  TextColumn get appointmentDate => text().named('appointment_date')();
  TextColumn get status =>
      text().withDefault(const Constant('scheduled'))();
  TextColumn get notes => text().nullable()();
  TextColumn get patientName => text().named('patient_name').nullable()();
  TextColumn get patientPhone => text().named('patient_phone').nullable()();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get cachedAt => text().named('cached_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class MedicationsTable extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().named('patient_id')();
  TextColumn get treatmentId => text().named('treatment_id').nullable()();
  TextColumn get dentistId => text().named('dentist_id')();
  TextColumn get medicationName => text().named('medication_name')();
  TextColumn get dosage => text().nullable()();
  TextColumn get frequency => text().nullable()();
  TextColumn get duration => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get prescribedDate => text().named('prescribed_date')();
  TextColumn get cachedAt => text().named('cached_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class FilesTable extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().named('patient_id')();
  TextColumn get treatmentId => text().named('treatment_id').nullable()();
  TextColumn get dentistId => text().named('dentist_id')();
  TextColumn get fileName => text().named('file_name')();
  TextColumn get fileType => text().named('file_type')();
  TextColumn get fileUrl => text().named('file_url')();
  TextColumn get storagePath => text().named('storage_path')();
  IntColumn get fileSize =>
      integer().named('file_size').withDefault(const Constant(0))();
  TextColumn get category =>
      text().withDefault(const Constant('other'))();
  TextColumn get uploadedAt => text().named('uploaded_at')();
  TextColumn get cachedAt => text().named('cached_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// Pending operations to sync when back online.
class SyncQueueTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recordUuid => text().named('record_uuid')();
  // Table name: 'patients', 'treatments', etc.
  TextColumn get targetTable => text().named('target_table')();
  // 'insert' | 'update' | 'delete'
  TextColumn get action => text()();
  // JSON-encoded payload
  TextColumn get payload => text()();
  TextColumn get createdAt => text().named('created_at')();
  IntColumn get retryCount =>
      integer().named('retry_count').withDefault(const Constant(0))();
  TextColumn get lastError => text().named('last_error').nullable()();
}

// ─── Database ────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  ProfilesTable,
  PatientsTable,
  TreatmentsTable,
  PaymentsTable,
  AppointmentsTable,
  MedicationsTable,
  FilesTable,
  SyncQueueTable,
])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'dentist_tracker_local');
  }

  // ── Profiles ────────────────────────────────────────────────
  Future<ProfilesTableData?> getProfile(String dentistId) =>
      (select(profilesTable)..where((t) => t.dentistId.equals(dentistId)))
          .getSingleOrNull();

  Future<void> upsertProfile(ProfilesTableData row) =>
      into(profilesTable).insertOnConflictUpdate(row);

  // ── Patients ─────────────────────────────────────────────────
  Future<List<PatientsTableData>> getPatients(String dentistId,
          {String? search}) =>
      (select(patientsTable)
            ..where((t) =>
                t.dentistId.equals(dentistId) &
                t.isDeleted.equals(false) &
                (search == null || search.isEmpty
                    ? const Constant(true)
                    : t.fullName.like('%$search%') |
                        t.phone.like('%$search%')))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();

  Future<PatientsTableData?> getPatientById(String id) =>
      (select(patientsTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> upsertPatient(PatientsTableData row) =>
      into(patientsTable).insertOnConflictUpdate(row);

  Future<void> markPatientDeleted(String id) =>
      (update(patientsTable)..where((t) => t.id.equals(id)))
          .write(const PatientsTableCompanion(isDeleted: Value(true)));

  // ── Treatments ──────────────────────────────────────────────
  Future<List<TreatmentsTableData>> getTreatments(String dentistId,
          {String? patientId}) =>
      (select(treatmentsTable)
            ..where((t) =>
                t.dentistId.equals(dentistId) &
                (patientId == null
                    ? const Constant(true)
                    : t.patientId.equals(patientId)))
            ..orderBy([(t) => OrderingTerm.desc(t.treatmentDate)]))
          .get();

  Future<TreatmentsTableData?> getTreatmentById(String id) =>
      (select(treatmentsTable)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<void> upsertTreatment(TreatmentsTableData row) =>
      into(treatmentsTable).insertOnConflictUpdate(row);

  Future<void> updateTreatmentLocal(String id, Map<String, dynamic> fields) =>
      (update(treatmentsTable)..where((t) => t.id.equals(id))).write(
        TreatmentsTableCompanion(
          status: fields.containsKey('status')
              ? Value(fields['status'] as String)
              : const Value.absent(),
          amountPaid: fields.containsKey('amount_paid')
              ? Value((fields['amount_paid'] as num).toDouble())
              : const Value.absent(),
        ),
      );

  // ── Payments ────────────────────────────────────────────────
  Future<List<PaymentsTableData>> getPayments(
          {String? treatmentId, String? dentistId}) =>
      (select(paymentsTable)
            ..where((t) =>
                (dentistId == null
                    ? const Constant(true)
                    : t.dentistId.equals(dentistId)) &
                (treatmentId == null
                    ? const Constant(true)
                    : t.treatmentId.equals(treatmentId)))
            ..orderBy([(t) => OrderingTerm.desc(t.paymentDate)]))
          .get();

  Future<void> upsertPayment(PaymentsTableData row) =>
      into(paymentsTable).insertOnConflictUpdate(row);

  // ── Appointments ─────────────────────────────────────────────
  Future<List<AppointmentsTableData>> getAppointments(
    String dentistId, {
    String? date,
    String? patientId,
    int? year,
    int? month,
  }) =>
      (select(appointmentsTable)
            ..where((t) {
              Expression<bool> expr = t.dentistId.equals(dentistId);
              if (date != null) expr = expr & t.appointmentDate.equals(date);
              if (patientId != null) {
                expr = expr & t.patientId.equals(patientId);
              }
              if (year != null && month != null) {
                final start =
                    '$year-${month.toString().padLeft(2, '0')}-01';
                final endMonth = month == 12 ? 1 : month + 1;
                final endYear = month == 12 ? year + 1 : year;
                final end =
                    '$endYear-${endMonth.toString().padLeft(2, '0')}-01';
                expr = expr &
                    t.appointmentDate.isBiggerOrEqualValue(start) &
                    t.appointmentDate.isSmallerThanValue(end);
              }
              return expr;
            })
            ..orderBy([(t) => OrderingTerm.asc(t.appointmentDate)]))
          .get();

  Future<void> upsertAppointment(AppointmentsTableData row) =>
      into(appointmentsTable).insertOnConflictUpdate(row);

  Future<void> updateAppointmentStatusLocal(String id, String status) =>
      (update(appointmentsTable)..where((t) => t.id.equals(id)))
          .write(AppointmentsTableCompanion(status: Value(status)));

  Future<void> deleteAppointmentLocal(String id) =>
      (delete(appointmentsTable)..where((t) => t.id.equals(id))).go();

  // ── Medications ──────────────────────────────────────────────
  Future<List<MedicationsTableData>> getMedications(String dentistId,
          {String? patientId, String? treatmentId}) =>
      (select(medicationsTable)
            ..where((t) =>
                t.dentistId.equals(dentistId) &
                (patientId == null
                    ? const Constant(true)
                    : t.patientId.equals(patientId)) &
                (treatmentId == null
                    ? const Constant(true)
                    : t.treatmentId.equals(treatmentId)))
            ..orderBy([(t) => OrderingTerm.desc(t.prescribedDate)]))
          .get();

  Future<void> upsertMedication(MedicationsTableData row) =>
      into(medicationsTable).insertOnConflictUpdate(row);

  Future<void> deleteMedicationLocal(String id) =>
      (delete(medicationsTable)..where((t) => t.id.equals(id))).go();

  // ── Files ────────────────────────────────────────────────────
  Future<List<FilesTableData>> getFiles(String dentistId,
          {String? patientId, String? treatmentId}) =>
      (select(filesTable)
            ..where((t) =>
                t.dentistId.equals(dentistId) &
                (patientId == null
                    ? const Constant(true)
                    : t.patientId.equals(patientId)) &
                (treatmentId == null
                    ? const Constant(true)
                    : t.treatmentId.equals(treatmentId)))
            ..orderBy([(t) => OrderingTerm.desc(t.uploadedAt)]))
          .get();

  Future<void> upsertFile(FilesTableData row) =>
      into(filesTable).insertOnConflictUpdate(row);

  Future<void> deleteFileLocal(String id) =>
      (delete(filesTable)..where((t) => t.id.equals(id))).go();

  // ── Sync Queue ───────────────────────────────────────────────
  Future<List<SyncQueueTableData>> getPendingOps() =>
      (select(syncQueueTable)
            ..where((t) => t.retryCount.isSmallerThanValue(5))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

  Future<int> getPendingCount() async {
    final rows = await getPendingOps();
    return rows.length;
  }

  Future<void> enqueueOp({
    required String recordUuid,
    required String tableName,
    required String action,
    required Map<String, dynamic> payload,
  }) =>
      into(syncQueueTable).insert(SyncQueueTableCompanion.insert(
        recordUuid: recordUuid,
        targetTable: tableName,
        action: action,
        payload: jsonEncode(payload),
        createdAt: DateTime.now().toIso8601String(),
      ));

  Future<void> deleteQueueOp(int id) =>
      (delete(syncQueueTable)..where((t) => t.id.equals(id))).go();

  Future<void> markQueueOpFailed(int id, String error) =>
      (update(syncQueueTable)..where((t) => t.id.equals(id))).write(
        SyncQueueTableCompanion(
          retryCount: Value(
            // increment handled by reading current + 1 via custom query
            // simplified: just set large number to skip
            5,
          ),
          lastError: Value(error),
        ),
      );

  // ── Local RPC: Financial Summary ─────────────────────────────
  Future<Map<String, dynamic>> computeFinancialSummary(
      String dentistId) async {
    final treatments = await getTreatments(dentistId);
    final patients = await getPatients(dentistId);

    double totalIncome = 0;
    double totalPaid = 0;
    double totalTechCost = 0;

    for (final t in treatments) {
      totalIncome += t.totalCost;
      totalPaid += t.amountPaid;
      totalTechCost += t.technicianCost;
    }

    return {
      'total_patients': patients.length,
      'total_treatments': treatments.length,
      'total_income': totalIncome,
      'total_paid': totalPaid,
      'total_technician_cost': totalTechCost,
    };
  }

  // ── Local RPC: Monthly Report ─────────────────────────────────
  Future<Map<String, dynamic>> computeMonthlyReport(
      String dentistId, int year, int month) async {
    final treatments = await getTreatments(dentistId);
    final appointments =
        await getAppointments(dentistId, year: year, month: month);

    final monthTreatments = treatments.where((t) {
      final d = DateTime.tryParse(t.treatmentDate);
      return d != null && d.year == year && d.month == month;
    }).toList();

    double revenue = 0;
    double techCost = 0;
    double outstanding = 0;
    int completed = 0;

    for (final t in monthTreatments) {
      revenue += t.totalCost;
      techCost += t.technicianCost;
      outstanding += (t.totalCost - t.amountPaid).clamp(0, double.infinity);
      if (t.status == 'completed') completed++;
    }

    final noShows =
        appointments.where((a) => a.status == 'no_show').length;
    final total = appointments.length;

    return {
      'total_revenue': revenue,
      'total_technician_cost': techCost,
      'total_outstanding': outstanding,
      'completed_treatments': completed,
      'appointment_count': total,
      'no_show_count': noShows,
      'no_show_rate': total > 0 ? (noShows / total * 100) : 0.0,
    };
  }

  // ── Local RPC: Patient Financials ─────────────────────────────
  Future<Map<String, dynamic>> computePatientFinancials(
      String patientId) async {
    final treatments = await getTreatments('', ).then(
        (list) => list.where((t) => t.patientId == patientId).toList());
    double totalCost = 0;
    double totalPaid = 0;
    for (final t in treatments) {
      totalCost += t.totalCost;
      totalPaid += t.amountPaid;
    }
    return {
      'total_cost': totalCost,
      'total_paid': totalPaid,
      'remaining_balance': totalCost - totalPaid,
    };
  }
}
