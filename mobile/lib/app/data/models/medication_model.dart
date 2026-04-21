class MedicationModel {
  final String id;
  final String patientId;
  final String? treatmentId;
  final String dentistId;
  final String medicationName;
  final String? dosage;
  final String? frequency;
  final String? duration;
  final String? notes;
  final DateTime prescribedDate;

  MedicationModel({
    required this.id,
    required this.patientId,
    this.treatmentId,
    required this.dentistId,
    required this.medicationName,
    this.dosage,
    this.frequency,
    this.duration,
    this.notes,
    DateTime? prescribedDate,
  }) : prescribedDate = prescribedDate ?? DateTime.now();

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      treatmentId: json['treatment_id'] as String?,
      dentistId: json['dentist_id'] as String,
      medicationName: json['medication_name'] as String? ?? '',
      dosage: json['dosage'] as String?,
      frequency: json['frequency'] as String?,
      duration: json['duration'] as String?,
      notes: json['notes'] as String?,
      prescribedDate: json['prescribed_date'] != null
          ? DateTime.parse(json['prescribed_date'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'treatment_id': treatmentId,
      'dentist_id': dentistId,
      'medication_name': medicationName,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'notes': notes,
      'prescribed_date': prescribedDate.toIso8601String(),
    };
  }

  MedicationModel copyWith({
    String? id,
    String? patientId,
    String? treatmentId,
    String? dentistId,
    String? medicationName,
    String? dosage,
    String? frequency,
    String? duration,
    String? notes,
    DateTime? prescribedDate,
  }) {
    return MedicationModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      treatmentId: treatmentId ?? this.treatmentId,
      dentistId: dentistId ?? this.dentistId,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      notes: notes ?? this.notes,
      prescribedDate: prescribedDate ?? this.prescribedDate,
    );
  }
}
