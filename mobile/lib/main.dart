import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/config/env_config.dart';
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

  // ─── Validate env vars (graceful — show error UI instead of crashing) ───
  if (EnvConfig.supabaseUrl.isEmpty || EnvConfig.supabaseAnonKey.isEmpty) {
    runApp(_buildErrorApp(
      'Configuration Error',
      'Missing required environment variables.\n'
      'The app was not built with the required --dart-define flags.\n\n'
      'SUPABASE_URL: ${EnvConfig.supabaseUrl.isEmpty ? "❌ MISSING" : "✅"}\n'
      'SUPABASE_ANON_KEY: ${EnvConfig.supabaseAnonKey.isEmpty ? "❌ MISSING" : "✅"}',
    ));
    return;
  }

  try {
    // Initialize Supabase with compile-time environment config
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
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
  } catch (e) {
    runApp(_buildErrorApp('Startup Error', e.toString()));
  }
}

/// Fallback error screen shown when the app fails to initialize.
/// This prevents the app from freezing on the native splash screen.
Widget _buildErrorApp(String title, String message) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
              const SizedBox(height: 24),
              Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.6)),
            ],
          ),
        ),
      ),
    ),
  );
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
