/// App-wide constants for Dentist Tracker.
class AppConstants {
  AppConstants._();

  // ─── App Info ──────────────────────────────────────────────────────
  static const String appName = 'Dentist Tracker';
  static const String appVersion = '1.0.0';

  // ─── API (OTP Backend) ────────────────────────────────────────────
  // Change this to your machine's local IP for physical device testing,
  // or the deployed admin URL in production.
  static const String apiBaseUrl = 'http://192.168.43.148:3000';

  // ─── Currency ──────────────────────────────────────────────────────
  static const String currency = 'YER';
  static const String currencySymbol = 'ر.ي';

  // ─── Defaults ──────────────────────────────────────────────────────
  static const double defaultRevenuePercentage = 100.0;
  static const int maxFileUploadSizeMB = 10;
  static const int maxFileUploadSizeBytes = maxFileUploadSizeMB * 1024 * 1024;

  // ─── Storage Keys (GetStorage) ─────────────────────────────────────
  static const String storageThemeKey = 'theme_mode';
  static const String storageLocaleKey = 'locale';
  static const String storageFirstLaunchKey = 'first_launch';

  // ─── Supabase Table Names ──────────────────────────────────────────
  static const String tableProfiles = 'profiles';
  static const String tablePatients = 'patients';
  static const String tableTreatments = 'treatments';
  static const String tablePayments = 'payments';
  static const String tableAppointments = 'appointments';
  static const String tableFiles = 'files';
  static const String tableMedications = 'medications';

  // ─── Supabase Storage ──────────────────────────────────────────────
  static const String storageBucket = 'patient-files';

  // ─── Treatment Status ──────────────────────────────────────────────
  static const String statusInProgress = 'in_progress';
  static const String statusCompleted = 'completed';

  // ─── Appointment Status ────────────────────────────────────────────
  static const String appointmentScheduled = 'scheduled';
  static const String appointmentCompleted = 'completed';
  static const String appointmentNoShow = 'no_show';

  // ─── File Categories ───────────────────────────────────────────────
  static const String fileCategoryXray = 'xray';
  static const String fileCategoryReport = 'report';
  static const String fileCategoryScan = 'scan';
  static const String fileCategoryOther = 'other';

  // ─── Payment Methods ───────────────────────────────────────────────
  static const String paymentCash = 'cash';
  static const String paymentBankTransfer = 'bank_transfer';
  static const String paymentOther = 'other';

  // ─── Animation Durations ───────────────────────────────────────────
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 500);
}
