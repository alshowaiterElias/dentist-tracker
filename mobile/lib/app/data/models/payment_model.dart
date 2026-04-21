class PaymentModel {
  final String id;
  final String treatmentId;
  final String dentistId;
  final double amount;
  final String paymentMethod;
  final String? notes;
  final DateTime paymentDate;

  // Joined data
  final String? patientName;
  final String? procedureType;

  PaymentModel({
    required this.id,
    required this.treatmentId,
    required this.dentistId,
    required this.amount,
    this.paymentMethod = 'cash',
    this.notes,
    DateTime? paymentDate,
    this.patientName,
    this.procedureType,
  }) : paymentDate = paymentDate ?? DateTime.now();

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String,
      treatmentId: json['treatment_id'] as String,
      dentistId: json['dentist_id'] as String,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      paymentMethod: json['payment_method'] as String? ?? 'cash',
      notes: json['notes'] as String?,
      paymentDate: json['payment_date'] != null
          ? DateTime.parse(json['payment_date'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'treatment_id': treatmentId,
      'dentist_id': dentistId,
      'amount': amount,
      'payment_method': paymentMethod,
      'notes': notes,
      'payment_date': paymentDate.toIso8601String(),
    };
  }

  PaymentModel copyWith({
    String? id,
    String? treatmentId,
    String? dentistId,
    double? amount,
    String? paymentMethod,
    String? notes,
    DateTime? paymentDate,
    String? patientName,
    String? procedureType,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      treatmentId: treatmentId ?? this.treatmentId,
      dentistId: dentistId ?? this.dentistId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      paymentDate: paymentDate ?? this.paymentDate,
      patientName: patientName ?? this.patientName,
      procedureType: procedureType ?? this.procedureType,
    );
  }
}
