/// A read-only view model for one row in the daily patient schedule table.
/// Joins appointment + treatment + patient data. Not stored in DB.
class DailyVisitModel {
  final String appointmentId;
  final String patientId;
  final String patientName;
  final String? treatmentId;
  final String? procedureType;
  final double totalCost;
  final double amountPaid;
  final DateTime? nextAppointment;
  final String appointmentStatus; // scheduled / completed / no_show
  final String? notes;

  DailyVisitModel({
    required this.appointmentId,
    required this.patientId,
    required this.patientName,
    this.treatmentId,
    this.procedureType,
    this.totalCost = 0,
    this.amountPaid = 0,
    this.nextAppointment,
    this.appointmentStatus = 'scheduled',
    this.notes,
  });

  double get remaining => totalCost - amountPaid;
  bool get attended => appointmentStatus == 'completed';
}
