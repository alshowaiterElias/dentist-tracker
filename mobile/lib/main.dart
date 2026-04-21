import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/constants/app_constants.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/translations/app_translations.dart';
import 'app/modules/auth/controllers/auth_controller.dart';
import 'app/data/local/local_database.dart';
import 'app/services/connectivity_service.dart';
import 'app/services/sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage for local preferences
  await GetStorage.init();

  // Initialize date formatting for intl package
  await initializeDateFormatting('en');
  await initializeDateFormatting('ar');

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://rnvyrazifxiskhuaowhw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJudnlyYXppZnhpc2todWFvd2h3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY2ODE0NTMsImV4cCI6MjA5MjI1NzQ1M30.-mN8T2Kn6Pjn5AfeyZorhkZgalKUW5Fmt2UdQ4qHkBU',
  );

  // ─── Offline-first services ──────────────────────────────────────────
  final localDb = LocalDatabase();
  await Get.putAsync<ConnectivityService>(
    () async => ConnectivityService(),
    permanent: true,
  );
  Get.put<SyncService>(
    SyncService(localDb),
    tag: 'sync_service',
    permanent: true,
  );
  // Also put LocalDatabase so AppRepository can find it via Get if needed
  Get.put<LocalDatabase>(localDb, permanent: true);

  runApp(const DentistTrackerApp());
}

class DentistTrackerApp extends StatelessWidget {
  const DentistTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();

    // Read saved preferences
    final savedLocale = storage.read<String>(AppConstants.storageLocaleKey);
    final savedTheme = storage.read<String>(AppConstants.storageThemeKey);

    // Determine initial locale
    Locale locale;
    if (savedLocale == 'ar') {
      locale = const Locale('ar', 'SA');
    } else {
      locale = const Locale('en', 'US');
    }

    // Determine initial theme
    ThemeMode themeMode;
    if (savedTheme == 'dark') {
      themeMode = ThemeMode.dark;
    } else if (savedTheme == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }

    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // ─── Theme ─────────────────────────────────────────
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,

      // ─── Localization ──────────────────────────────────
      translations: AppTranslations(),
      locale: locale,
      fallbackLocale: const Locale('en', 'US'),

      // ─── Routing ───────────────────────────────────────
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,

      // ─── Default Transition ────────────────────────────
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),

      // ─── Scroll Behavior ───────────────────────────────
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),

      // ─── Auth Listener ─────────────────────────────────
      onInit: () {
        final authController = Get.put(AuthController(), permanent: true);
        authController.setupAuthListener();
      },
    );
  }
}
