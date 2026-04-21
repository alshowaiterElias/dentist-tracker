import 'dart:convert';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/patient_model.dart';
import '../models/treatment_model.dart';
import '../models/payment_model.dart';
import '../models/appointment_model.dart';
import '../models/medication_model.dart';
import '../models/file_model.dart';
import '../models/profile_model.dart';
import '../providers/supabase_provider.dart';
import '../local/local_database.dart';
import '../../services/connectivity_service.dart';
import '../../services/sync_service.dart';

// ─── Converters: model ↔ local DB row ────────────────────────────────────────

extension _ProfileConvert on ProfileModel {
  ProfilesTableData toLocal() => ProfilesTableData(
        id: id,
        dentistId: id,
        fullName: fullName,
        email: email,
        phone: phone,
        revenuePercentage: revenuePercentage,
        preferredLanguage: preferredLanguage,
        cachedAt: DateTime.now().toIso8601String(),
      );
}

extension _ProfileLocalConvert on ProfilesTableData {
  ProfileModel toModel() => ProfileModel(
        id: id,
        email: email,
        phone: phone,
        fullName: fullName,
        revenuePercentage: revenuePercentage,
        preferredLanguage: preferredLanguage,
      );
}

extension _PatientConvert on PatientModel {
  PatientsTableData toLocal() => PatientsTableData(
        id: id,
        dentistId: dentistId,
        fullName: fullName,
        phone: phone,
        age: age,
        medicalStatus: medicalStatus,
        condition: condition,
        notes: notes,
        isDeleted: false,
        createdAt: createdAt.toIso8601String(),
        updatedAt: updatedAt.toIso8601String(),
        cachedAt: DateTime.now().toIso8601String(),
      );
}

extension _PatientLocalConvert on PatientsTableData {
  PatientModel toModel() => PatientModel(
        id: id,
        dentistId: dentistId,
        fullName: fullName,
        phone: phone,
        age: age,
        medicalStatus: medicalStatus,
        condition: condition,
        notes: notes,
        createdAt: DateTime.tryParse(createdAt),
        updatedAt: DateTime.tryParse(updatedAt),
      );
}

extension _TreatmentConvert on TreatmentModel {
  TreatmentsTableData toLocal() => TreatmentsTableData(
        id: id,
        patientId: patientId,
        dentistId: dentistId,
        procedureType: procedureType,
        toothNumbers: jsonEncode(toothNumbers),
        description: description,
        treatmentNotes: notes,
        totalCost: totalCost,
        technicianCost: technicianCost,
        amountPaid: amountPaid,
        status: status,
        treatmentDate: treatmentDate.toIso8601String(),
        createdAt: createdAt.toIso8601String(),
        patientName: patientName,
        cachedAt: DateTime.now().toIso8601String(),
      );
}

extension _TreatmentLocalConvert on TreatmentsTableData {
  TreatmentModel toModel() => TreatmentModel(
        id: id,
        patientId: patientId,
        dentistId: dentistId,
        procedureType: procedureType,
        toothNumbers: (jsonDecode(toothNumbers) as List)
            .map((e) => e as int)
            .toList(),
        description: description,
        notes: treatmentNotes,
        totalCost: totalCost,
        technicianCost: technicianCost,
        amountPaid: amountPaid,
        status: status,
        treatmentDate: DateTime.tryParse(treatmentDate),
        createdAt: DateTime.tryParse(createdAt),
        patientName: patientName,
      );
}

extension _PaymentConvert on PaymentModel {
  PaymentsTableData toLocal() => PaymentsTableData(
        id: id,
        treatmentId: treatmentId,
        dentistId: dentistId,
        amount: amount,
        paymentMethod: paymentMethod,
        notes: notes,
        paymentDate: paymentDate.toIso8601String(),
        cachedAt: DateTime.now().toIso8601String(),
      );
}

extension _PaymentLocalConvert on PaymentsTableData {
  PaymentModel toModel() => PaymentModel(
        id: id,
        treatmentId: treatmentId,
        dentistId: dentistId,
        amount: amount,
        paymentMethod: paymentMethod,
        notes: notes,
        paymentDate: DateTime.tryParse(paymentDate),
      );
}

extension _AppointmentConvert on AppointmentModel {
  AppointmentsTableData toLocal() => AppointmentsTableData(
        id: id,
        patientId: patientId,
        dentistId: dentistId,
        treatmentId: treatmentId,
        appointmentDate:
            '${appointmentDate.year}-${appointmentDate.month.toString().padLeft(2, '0')}-${appointmentDate.day.toString().padLeft(2, '0')}',
        status: status,
        notes: notes,
        patientName: patientName,
        patientPhone: patientPhone,
        createdAt: createdAt.toIso8601String(),
        cachedAt: DateTime.now().toIso8601String(),
      );
}

extension _AppointmentLocalConvert on AppointmentsTableData {
  AppointmentModel toModel() => AppointmentModel(
        id: id,
        patientId: patientId,
        dentistId: dentistId,
        treatmentId: treatmentId,
        appointmentDate:
            DateTime.tryParse(appointmentDate) ?? DateTime.now(),
        status: status,
        notes: notes,
        createdAt: DateTime.tryParse(createdAt),
        patientName: patientName,
        patientPhone: patientPhone,
      );
}

extension _MedicationConvert on MedicationModel {
  MedicationsTableData toLocal() => MedicationsTableData(
        id: id,
        patientId: patientId,
        treatmentId: treatmentId,
        dentistId: dentistId,
        medicationName: medicationName,
        dosage: dosage,
        frequency: frequency,
        duration: duration,
        notes: notes,
        prescribedDate: prescribedDate.toIso8601String(),
        cachedAt: DateTime.now().toIso8601String(),
      );
}

extension _MedicationLocalConvert on MedicationsTableData {
  MedicationModel toModel() => MedicationModel(
        id: id,
        patientId: patientId,
        treatmentId: treatmentId,
        dentistId: dentistId,
        medicationName: medicationName,
        dosage: dosage,
        frequency: frequency,
        duration: duration,
        notes: notes,
        prescribedDate: DateTime.tryParse(prescribedDate),
      );
}

extension _FileConvert on FileModel {
  FilesTableData toLocal() => FilesTableData(
        id: id,
        patientId: patientId,
        treatmentId: treatmentId,
        dentistId: dentistId,
        fileName: fileName,
        fileType: fileType,
        fileUrl: fileUrl,
        storagePath: storagePath,
        fileSize: fileSize,
        category: category,
        uploadedAt: uploadedAt.toIso8601String(),
        cachedAt: DateTime.now().toIso8601String(),
      );
}

extension _FileLocalConvert on FilesTableData {
  FileModel toModel() => FileModel(
        id: id,
        patientId: patientId,
        treatmentId: treatmentId,
        dentistId: dentistId,
        fileName: fileName,
        fileType: fileType,
        fileUrl: fileUrl,
        storagePath: storagePath,
        fileSize: fileSize,
        category: category,
        uploadedAt: DateTime.tryParse(uploadedAt),
      );
}

// ─── Repository ───────────────────────────────────────────────────────────────

/// Local-first repository. Reads from local SQLite cache, writes locally
/// and syncs to Supabase when online. Falls back gracefully when offline.
class AppRepository {
  LocalDatabase get _db => Get.find<LocalDatabase>();

  bool get _online => ConnectivityService.to.isOnline.value;

  SyncService get _sync => SyncService.to;

  static const _uuid = Uuid();

  // ─── Profiles ────────────────────────────────────────────────────────

  Future<ProfileModel?> getProfile() async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return null;

    // 1. Return local first
    final local = await _db.getProfile(userId);
    final localModel = local?.toModel();

    // 2. Refresh from remote in background if online
    if (_online) {
      _bgSync(() async {
        final data = await SupabaseProvider.from('profiles')
            .select()
            .eq('id', userId)
            .maybeSingle();
        if (data != null) {
          final model = ProfileModel.fromJson(data);
          await _db.upsertProfile(model.toLocal());
        }
      });
    }

    return localModel;
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return;

    // Update local cache immediately
    final local = await _db.getProfile(userId);
    if (local != null) {
      await _db.upsertProfile(ProfilesTableData(
        id: local.id,
        dentistId: local.dentistId,
        fullName: updates['full_name'] as String? ?? local.fullName,
        email: local.email,
        phone: local.phone,
        revenuePercentage: (updates['revenue_percentage'] as num?)
                ?.toDouble() ??
            local.revenuePercentage,
        preferredLanguage:
            updates['preferred_language'] as String? ?? local.preferredLanguage,
        cachedAt: DateTime.now().toIso8601String(),
      ));
    }

    if (_online) {
      await SupabaseProvider.from('profiles').update(updates).eq('id', userId);
    } else {
      await _sync.enqueue(
        recordUuid: userId,
        tableName: 'profiles',
        action: 'update',
        payload: {'id': userId, ...updates},
      );
    }
  }

  // ─── Patients ─────────────────────────────────────────────────────────

  Future<List<PatientModel>> getPatients({String? search}) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    // 1. Return local cache immediately
    final local =
        await _db.getPatients(userId, search: search);
    final localModels = local.map((e) => e.toModel()).toList();

    // 2. Background sync from Supabase
    if (_online) {
      _bgSync(() async {
        var query = SupabaseProvider.from('patients')
            .select()
            .eq('dentist_id', userId)
            .eq('is_deleted', false);
        final data = await query.order('created_at', ascending: false);
        for (final row in data as List) {
          final model = PatientModel.fromJson(row);
          await _db.upsertPatient(model.toLocal());
        }
      });
    }

    return localModels;
  }

  Future<PatientModel?> getPatient(String id) async {
    // Return local first
    final local = await _db.getPatientById(id);
    final localModel = local?.toModel();

    if (_online) {
      _bgSync(() async {
        final data = await SupabaseProvider.from('patients')
            .select()
            .eq('id', id)
            .maybeSingle();
        if (data != null) {
          await _db.upsertPatient(PatientModel.fromJson(data).toLocal());
        }
      });
    }

    return localModel;
  }

  Future<PatientModel> createPatient(Map<String, dynamic> patient) async {
    final id = patient['id'] as String? ?? _uuid.v4();
    final now = DateTime.now().toIso8601String();
    final fullPayload = {
      'id': id,
      'created_at': now,
      'updated_at': now,
      'is_deleted': false,
      ...patient,
    };

    // Write to local DB immediately
    final model = PatientModel.fromJson(fullPayload);
    await _db.upsertPatient(model.toLocal());

    if (_online) {
      // Write to Supabase and get canonical response
      try {
        final data = await SupabaseProvider.from('patients')
            .insert(patient)
            .select()
            .single();
        final remoteModel = PatientModel.fromJson(data);
        await _db.upsertPatient(remoteModel.toLocal());
        return remoteModel;
      } catch (e) {
        // Remote failed — return local optimistic model
        return model;
      }
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'patients',
        action: 'insert',
        payload: fullPayload,
      );
      return model;
    }
  }

  Future<void> updatePatient(String id, Map<String, dynamic> updates) async {
    // Update local
    final local = await _db.getPatientById(id);
    if (local != null) {
      await _db.upsertPatient(PatientsTableData(
        id: local.id,
        dentistId: local.dentistId,
        fullName: updates['full_name'] as String? ?? local.fullName,
        phone: updates['phone'] as String? ?? local.phone,
        age: updates['age'] as int? ?? local.age,
        medicalStatus:
            updates['medical_status'] as String? ?? local.medicalStatus,
        condition: updates['condition'] as String? ?? local.condition,
        notes: updates['notes'] as String? ?? local.notes,
        isDeleted: local.isDeleted,
        createdAt: local.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
        cachedAt: DateTime.now().toIso8601String(),
      ));
    }

    if (_online) {
      await SupabaseProvider.from('patients').update(updates).eq('id', id);
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'patients',
        action: 'update',
        payload: {'id': id, ...updates},
      );
    }
  }

  Future<void> softDeletePatient(String id) async {
    await _db.markPatientDeleted(id);

    if (_online) {
      await SupabaseProvider.from('patients')
          .update({'is_deleted': true}).eq('id', id);
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'patients',
        action: 'soft_delete_patient',
        payload: {'id': id},
      );
    }
  }

  Future<Map<String, dynamic>> getPatientFinancials(String patientId) async {
    if (_online) {
      try {
        final result = await SupabaseProvider.rpc(
          'get_patient_financials',
          params: {'p_patient_id': patientId},
        );
        return result as Map<String, dynamic>;
      } catch (_) {}
    }
    // Fallback: compute locally
    return _db.computePatientFinancials(patientId);
  }

  // ─── Treatments ───────────────────────────────────────────────────────

  Future<List<TreatmentModel>> getTreatments({String? patientId}) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    final local = await _db.getTreatments(userId, patientId: patientId);
    final localModels = local.map((e) => e.toModel()).toList();

    if (_online) {
      _bgSync(() async {
        var query = SupabaseProvider.from('treatments')
            .select('*, patients(full_name)')
            .eq('dentist_id', userId);
        if (patientId != null) query = query.eq('patient_id', patientId);
        final data = await query.order('treatment_date', ascending: false);
        for (final row in data as List) {
          await _db.upsertTreatment(TreatmentModel.fromJson(row).toLocal());
        }
      });
    }

    return localModels;
  }

  Future<TreatmentModel?> getTreatment(String id) async {
    final local = await _db.getTreatmentById(id);

    if (_online) {
      _bgSync(() async {
        final data = await SupabaseProvider.from('treatments')
            .select('*, patients(full_name)')
            .eq('id', id)
            .maybeSingle();
        if (data != null) {
          await _db.upsertTreatment(TreatmentModel.fromJson(data).toLocal());
        }
      });
    }

    return local?.toModel();
  }

  Future<TreatmentModel> createTreatment(
      Map<String, dynamic> treatment) async {
    final id = treatment['id'] as String? ?? _uuid.v4();
    final now = DateTime.now().toIso8601String();
    final fullPayload = {'id': id, 'created_at': now, ...treatment};

    final model = TreatmentModel.fromJson(fullPayload);
    await _db.upsertTreatment(model.toLocal());

    if (_online) {
      try {
        final data = await SupabaseProvider.from('treatments')
            .insert(treatment)
            .select()
            .single();
        final remote = TreatmentModel.fromJson(data);
        await _db.upsertTreatment(remote.toLocal());
        return remote;
      } catch (_) {
        return model;
      }
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'treatments',
        action: 'insert',
        payload: fullPayload,
      );
      return model;
    }
  }

  Future<void> updateTreatment(
      String id, Map<String, dynamic> updates) async {
    await _db.updateTreatmentLocal(id, updates);

    if (_online) {
      await SupabaseProvider.from('treatments').update(updates).eq('id', id);
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'treatments',
        action: 'update',
        payload: {'id': id, ...updates},
      );
    }
  }

  // ─── Payments ─────────────────────────────────────────────────────────

  Future<List<PaymentModel>> getPayments({
    String? treatmentId,
    String? dentistId,
  }) async {
    final uid = dentistId ?? SupabaseProvider.userId;
    if (uid == null) return [];

    final local =
        await _db.getPayments(treatmentId: treatmentId, dentistId: uid);
    final localModels = local.map((e) => e.toModel()).toList();

    if (_online) {
      _bgSync(() async {
        var query = SupabaseProvider.from('payments')
            .select()
            .eq('dentist_id', uid);
        if (treatmentId != null) {
          query = query.eq('treatment_id', treatmentId);
        }
        final data = await query.order('payment_date', ascending: false);
        for (final row in data as List) {
          await _db.upsertPayment(PaymentModel.fromJson(row).toLocal());
        }
      });
    }

    return localModels;
  }

  Future<PaymentModel> createPayment(Map<String, dynamic> payment) async {
    final id = payment['id'] as String? ?? _uuid.v4();
    final now = DateTime.now().toIso8601String();
    final fullPayload = {'id': id, 'payment_date': now, ...payment};

    final model = PaymentModel.fromJson(fullPayload);
    await _db.upsertPayment(model.toLocal());

    if (_online) {
      try {
        final data = await SupabaseProvider.from('payments')
            .insert(payment)
            .select()
            .single();
        final remote = PaymentModel.fromJson(data);
        await _db.upsertPayment(remote.toLocal());
        return remote;
      } catch (_) {
        return model;
      }
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'payments',
        action: 'insert',
        payload: fullPayload,
      );
      return model;
    }
  }

  // ─── Appointments ─────────────────────────────────────────────────────

  Future<List<AppointmentModel>> getAppointments({
    DateTime? date,
    String? patientId,
    int? year,
    int? month,
  }) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    final dateStr = date != null
        ? '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
        : null;

    final local = await _db.getAppointments(
      userId,
      date: dateStr,
      patientId: patientId,
      year: year,
      month: month,
    );
    final localModels = local.map((e) => e.toModel()).toList();

    if (_online) {
      _bgSync(() async {
        var query = SupabaseProvider.from('appointments')
            .select('*, patients(full_name, phone)')
            .eq('dentist_id', userId);
        if (dateStr != null) query = query.eq('appointment_date', dateStr);
        if (patientId != null) query = query.eq('patient_id', patientId);
        if (year != null && month != null) {
          final start = '$year-${month.toString().padLeft(2, '0')}-01';
          final endMonth = month == 12 ? 1 : month + 1;
          final endYear = month == 12 ? year + 1 : year;
          final end = '$endYear-${endMonth.toString().padLeft(2, '0')}-01';
          query = query
              .gte('appointment_date', start)
              .lt('appointment_date', end);
        }
        final data = await query.order('appointment_date', ascending: true);
        for (final row in data as List) {
          await _db
              .upsertAppointment(AppointmentModel.fromJson(row).toLocal());
        }
      });
    }

    return localModels;
  }

  Future<AppointmentModel> createAppointment(
      Map<String, dynamic> apt) async {
    final id = apt['id'] as String? ?? _uuid.v4();
    final now = DateTime.now().toIso8601String();
    final fullPayload = {'id': id, 'created_at': now, 'status': 'scheduled', ...apt};

    final model = AppointmentModel.fromJson(fullPayload);
    await _db.upsertAppointment(model.toLocal());

    if (_online) {
      try {
        final data = await SupabaseProvider.from('appointments')
            .insert(apt)
            .select('*, patients(full_name, phone)')
            .single();
        final remote = AppointmentModel.fromJson(data);
        await _db.upsertAppointment(remote.toLocal());
        return remote;
      } catch (_) {
        return model;
      }
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'appointments',
        action: 'insert',
        payload: fullPayload,
      );
      return model;
    }
  }

  Future<void> updateAppointmentStatus(String id, String status) async {
    await _db.updateAppointmentStatusLocal(id, status);

    if (_online) {
      await SupabaseProvider.from('appointments')
          .update({'status': status}).eq('id', id);
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'appointments',
        action: 'update',
        payload: {'id': id, 'status': status},
      );
    }
  }

  Future<void> deleteAppointment(String id) async {
    await _db.deleteAppointmentLocal(id);

    if (_online) {
      await SupabaseProvider.from('appointments').delete().eq('id', id);
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'appointments',
        action: 'delete_appointment',
        payload: {'id': id},
      );
    }
  }

  // ─── Medications ──────────────────────────────────────────────────────

  Future<List<MedicationModel>> getMedications({
    String? patientId,
    String? treatmentId,
  }) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    final local = await _db.getMedications(userId,
        patientId: patientId, treatmentId: treatmentId);
    final localModels = local.map((e) => e.toModel()).toList();

    if (_online) {
      _bgSync(() async {
        var query = SupabaseProvider.from('medications')
            .select()
            .eq('dentist_id', userId);
        if (patientId != null) query = query.eq('patient_id', patientId);
        if (treatmentId != null) {
          query = query.eq('treatment_id', treatmentId);
        }
        final data = await query.order('prescribed_date', ascending: false);
        for (final row in data as List) {
          await _db.upsertMedication(MedicationModel.fromJson(row).toLocal());
        }
      });
    }

    return localModels;
  }

  Future<MedicationModel> createMedication(
      Map<String, dynamic> med) async {
    final id = med['id'] as String? ?? _uuid.v4();
    final now = DateTime.now().toIso8601String();
    final fullPayload = {'id': id, 'prescribed_date': now, ...med};

    final model = MedicationModel.fromJson(fullPayload);
    await _db.upsertMedication(model.toLocal());

    if (_online) {
      try {
        final data = await SupabaseProvider.from('medications')
            .insert(med)
            .select()
            .single();
        final remote = MedicationModel.fromJson(data);
        await _db.upsertMedication(remote.toLocal());
        return remote;
      } catch (_) {
        return model;
      }
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'medications',
        action: 'insert',
        payload: fullPayload,
      );
      return model;
    }
  }

  Future<void> deleteMedication(String id) async {
    await _db.deleteMedicationLocal(id);

    if (_online) {
      await SupabaseProvider.from('medications').delete().eq('id', id);
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'medications',
        action: 'delete_medication',
        payload: {'id': id},
      );
    }
  }

  // ─── Files ────────────────────────────────────────────────────────────

  Future<List<FileModel>> getFiles({
    String? patientId,
    String? treatmentId,
  }) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return [];

    final local = await _db.getFiles(userId,
        patientId: patientId, treatmentId: treatmentId);
    final localModels = local.map((e) => e.toModel()).toList();

    if (_online) {
      _bgSync(() async {
        var query = SupabaseProvider.from('files')
            .select()
            .eq('dentist_id', userId);
        if (patientId != null) query = query.eq('patient_id', patientId);
        if (treatmentId != null) {
          query = query.eq('treatment_id', treatmentId);
        }
        final data = await query.order('uploaded_at', ascending: false);
        for (final row in data as List) {
          await _db.upsertFile(FileModel.fromJson(row).toLocal());
        }
      });
    }

    return localModels;
  }

  Future<FileModel> createFileRecord(Map<String, dynamic> file) async {
    final id = file['id'] as String? ?? _uuid.v4();
    final now = DateTime.now().toIso8601String();
    final fullPayload = {'id': id, 'uploaded_at': now, ...file};

    final model = FileModel.fromJson(fullPayload);
    await _db.upsertFile(model.toLocal());

    if (_online) {
      try {
        final data = await SupabaseProvider.from('files')
            .insert(file)
            .select()
            .single();
        final remote = FileModel.fromJson(data);
        await _db.upsertFile(remote.toLocal());
        return remote;
      } catch (_) {
        return model;
      }
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'files',
        action: 'insert',
        payload: fullPayload,
      );
      return model;
    }
  }

  Future<void> deleteFile(String id, String storagePath) async {
    await _db.deleteFileLocal(id);

    if (_online) {
      await SupabaseProvider.storage.remove([storagePath]);
      await SupabaseProvider.from('files').delete().eq('id', id);
    } else {
      await _sync.enqueue(
        recordUuid: id,
        tableName: 'files',
        action: 'delete',
        payload: {'id': id, 'storage_path': storagePath},
      );
    }
  }

  // ─── Reports ──────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> getFinancialSummary() async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return {};

    if (_online) {
      try {
        final result = await SupabaseProvider.rpc(
          'get_financial_summary',
          params: {'p_dentist_id': userId},
        );
        // Cache individual records via background sync already handled
        return result as Map<String, dynamic>;
      } catch (_) {}
    }
    // Offline fallback — compute locally
    return _db.computeFinancialSummary(userId);
  }

  Future<Map<String, dynamic>> getMonthlyReport(int year, int month) async {
    final userId = SupabaseProvider.userId;
    if (userId == null) return {};

    if (_online) {
      try {
        final result = await SupabaseProvider.rpc(
          'get_monthly_report',
          params: {
            'p_dentist_id': userId,
            'p_year': year,
            'p_month': month,
          },
        );
        return result as Map<String, dynamic>;
      } catch (_) {}
    }
    return _db.computeMonthlyReport(userId, year, month);
  }

  // ─── Helpers ───────────────────────────────────────────────────────────

  /// Fire-and-forget background sync — errors are silently ignored.
  void _bgSync(Future<void> Function() fn) {
    fn().catchError((_) {});
  }
}
