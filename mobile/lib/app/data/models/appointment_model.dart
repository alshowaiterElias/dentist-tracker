class AppointmentModel {
  final String id;
  final String patientId;
  final String dentistId;
  final String? treatmentId;
  final DateTime appointmentDate;
  final String status;
  final String? notes;
  final DateTime createdAt;

  // Joined data
  final String? patientName;
  final String? patientPhone;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.dentistId,
    this.treatmentId,
    required this.appointmentDate,
    this.status = 'scheduled',
    this.notes,
    DateTime? createdAt,
    this.patientName,
    this.patientPhone,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isScheduled => status == 'scheduled';
  bool get isCompleted => status == 'completed';
  bool get isNoShow => status == 'no_show';

  bool get isToday {
    final now = DateTime.now();
    return appointmentDate.year == now.year &&
        appointmentDate.month == now.month &&
        appointmentDate.day == now.day;
  }

  bool get isPast {
    final today = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final aptDate = DateTime(
        appointmentDate.year, appointmentDate.month, appointmentDate.day);
    return aptDate.isBefore(today);
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      dentistId: json['dentist_id'] as String,
      treatmentId: json['treatment_id'] as String?,
      appointmentDate: DateTime.parse(json['appointment_date'] as String),
      status: json['status'] as String? ?? 'scheduled',
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      patientName: json['patients'] != null
          ? (json['patients'] as Map<String, dynamic>)['full_name'] as String?
          : null,
      patientPhone: json['patients'] != null
          ? (json['patients'] as Map<String, dynamic>)['phone'] as String?
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'dentist_id': dentistId,
      'treatment_id': treatmentId,
      'appointment_date':
          '${appointmentDate.year}-${appointmentDate.month.toString().padLeft(2, '0')}-${appointmentDate.day.toString().padLeft(2, '0')}',
      'status': status,
      'notes': notes,
    };
  }

  AppointmentModel copyWith({
    String? id,
    String? patientId,
    String? dentistId,
    String? treatmentId,
    DateTime? appointmentDate,
    String? status,
    String? notes,
    DateTime? createdAt,
    String? patientName,
    String? patientPhone,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      dentistId: dentistId ?? this.dentistId,
      treatmentId: treatmentId ?? this.treatmentId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
    );
  }
}
