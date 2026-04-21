class PatientModel {
  final String id;
  final String dentistId;
  final String fullName;
  final String phone;
  final int? age;
  final String? medicalStatus;
  final String? condition;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Calculated fields (not stored in DB, computed from joins)
  final double? totalCost;
  final double? totalPaid;
  final double? remainingBalance;
  final DateTime? nextAppointment;

  PatientModel({
    required this.id,
    required this.dentistId,
    required this.fullName,
    required this.phone,
    this.age,
    this.medicalStatus,
    this.condition,
    this.notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.totalCost,
    this.totalPaid,
    this.remainingBalance,
    this.nextAppointment,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String,
      dentistId: json['dentist_id'] as String,
      fullName: json['full_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      age: json['age'] as int?,
      medicalStatus: json['medical_status'] as String?,
      condition: json['condition'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dentist_id': dentistId,
      'full_name': fullName,
      'phone': phone,
      'age': age,
      'medical_status': medicalStatus,
      'condition': condition,
      'notes': notes,
    };
  }

  PatientModel copyWith({
    String? id,
    String? dentistId,
    String? fullName,
    String? phone,
    int? age,
    String? medicalStatus,
    String? condition,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? totalCost,
    double? totalPaid,
    double? remainingBalance,
    DateTime? nextAppointment,
  }) {
    return PatientModel(
      id: id ?? this.id,
      dentistId: dentistId ?? this.dentistId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      medicalStatus: medicalStatus ?? this.medicalStatus,
      condition: condition ?? this.condition,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalCost: totalCost ?? this.totalCost,
      totalPaid: totalPaid ?? this.totalPaid,
      remainingBalance: remainingBalance ?? this.remainingBalance,
      nextAppointment: nextAppointment ?? this.nextAppointment,
    );
  }
}
