class TreatmentModel {
  final String id;
  final String patientId;
  final String dentistId;
  final String procedureType;
  final List<String> toothNumbers;
  final String? description;
  final String? notes;
  final double totalCost;
  final double technicianCost;
  final double amountPaid;
  final String status;
  final DateTime treatmentDate;
  final DateTime createdAt;

  // Joined data (optional)
  final String? patientName;

  TreatmentModel({
    required this.id,
    required this.patientId,
    required this.dentistId,
    required this.procedureType,
    this.toothNumbers = const [],
    this.description,
    this.notes,
    this.totalCost = 0,
    this.technicianCost = 0,
    this.amountPaid = 0,
    this.status = 'in_progress',
    DateTime? treatmentDate,
    DateTime? createdAt,
    this.patientName,
  })  : treatmentDate = treatmentDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  /// Remaining balance = totalCost - amountPaid
  double get remainingBalance => totalCost - amountPaid;

  /// Net revenue after technician cost
  double get netRevenue => totalCost - technicianCost;

  /// Is fully paid?
  bool get isFullyPaid => amountPaid >= totalCost;

  /// Is completed?
  bool get isCompleted => status == 'completed';

  /// Calculate dentist share given a revenue percentage
  double dentistShare(double revenuePercentage) =>
      netRevenue * (revenuePercentage / 100);

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      dentistId: json['dentist_id'] as String,
      procedureType: json['procedure_type'] as String? ?? '',
      toothNumbers: json['tooth_numbers'] != null
          ? List<String>.from(
              (json['tooth_numbers'] as List).map((e) => e.toString()),
            )
          : [],
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      totalCost: (json['total_cost'] as num?)?.toDouble() ?? 0,
      technicianCost: (json['technician_cost'] as num?)?.toDouble() ?? 0,
      amountPaid: (json['amount_paid'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? 'in_progress',
      treatmentDate: json['treatment_date'] != null
          ? DateTime.parse(json['treatment_date'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      patientName: json['patients'] != null
          ? (json['patients'] as Map<String, dynamic>)['full_name'] as String?
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'dentist_id': dentistId,
      'procedure_type': procedureType,
      'tooth_numbers': toothNumbers,
      'description': description,
      'notes': notes,
      'total_cost': totalCost,
      'technician_cost': technicianCost,
      'amount_paid': amountPaid,
      'status': status,
      'treatment_date': treatmentDate.toIso8601String(),
    };
  }

  TreatmentModel copyWith({
    String? id,
    String? patientId,
    String? dentistId,
    String? procedureType,
    List<String>? toothNumbers,
    String? description,
    String? notes,
    double? totalCost,
    double? technicianCost,
    double? amountPaid,
    String? status,
    DateTime? treatmentDate,
    DateTime? createdAt,
    String? patientName,
  }) {
    return TreatmentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      dentistId: dentistId ?? this.dentistId,
      procedureType: procedureType ?? this.procedureType,
      toothNumbers: toothNumbers ?? this.toothNumbers,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      totalCost: totalCost ?? this.totalCost,
      technicianCost: technicianCost ?? this.technicianCost,
      amountPaid: amountPaid ?? this.amountPaid,
      status: status ?? this.status,
      treatmentDate: treatmentDate ?? this.treatmentDate,
      createdAt: createdAt ?? this.createdAt,
      patientName: patientName ?? this.patientName,
    );
  }
}
