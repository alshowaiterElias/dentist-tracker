import 'package:get/get.dart';
import 'app_routes.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/auth/views/email_verification_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/patients/bindings/patient_binding.dart';
import '../modules/patients/views/add_patient_view.dart';
import '../modules/patients/views/patient_detail_view.dart';
import '../modules/treatments/bindings/treatment_binding.dart';
import '../modules/treatments/views/add_treatment_view.dart';
import '../modules/treatments/views/treatment_detail_view.dart';
import '../modules/medications/bindings/medication_binding.dart';
import '../modules/medications/views/add_medication_view.dart';
import '../modules/appointments/bindings/appointment_binding.dart';
import '../modules/appointments/views/add_appointment_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/settings/views/about_view.dart';
import '../modules/settings/views/privacy_policy_view.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/dashboard/views/new_patient_visit_view.dart';
import '../modules/dashboard/views/returning_patient_visit_view.dart';
import '../modules/auth/views/deletion_pending_view.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/patients/views/edit_patient_view.dart';

/// GetX page route definitions.
class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.emailVerification,
      page: () => const EmailVerificationView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.addPatient,
      page: () => const AddPatientView(),
      binding: PatientBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.patientDetail,
      page: () => const PatientDetailView(),
      binding: PatientBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addTreatment,
      page: () => const AddTreatmentView(),
      binding: TreatmentBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.treatmentDetail,
      page: () => const TreatmentDetailView(),
      binding: TreatmentBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addMedication,
      page: () => const AddMedicationView(),
      binding: MedicationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addAppointment,
      page: () => const AddAppointmentView(),
      binding: AppointmentBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.newPatientVisit,
      page: () => const NewPatientVisitView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.returningPatientVisit,
      page: () => const ReturningPatientVisitView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.deletionPending,
      page: () => const DeletionPendingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.editPatient,
      page: () => const EditPatientView(),
      binding: PatientBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
