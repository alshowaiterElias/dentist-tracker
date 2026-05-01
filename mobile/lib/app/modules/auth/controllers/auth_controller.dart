import 'dart:convert';
import 'package:dentist_tracker/app/core/constants/app_constants.dart';
import 'package:dentist_tracker/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles authentication: email+password, phone OTP via Twilio.
class AuthController extends GetxController {
  final _supabase = Supabase.instance.client;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final otpController = TextEditingController();

  final isLoading = false.obs;
  final isOtpSent = false.obs;
  final authMode = 'email'.obs; // 'email' or 'phone'

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameController.dispose();
    otpController.dispose();
    super.onClose();
  }

  /// Toggle between email and phone auth
  void toggleAuthMode() {
    if (!AppConstants.isPhoneAuthEnabled && authMode.value == 'email') {
      // Phone auth is disabled — show Coming Soon message
      Get.snackbar(
        'phone_auth_coming_soon_title'.tr,
        'phone_auth_coming_soon_desc'.tr,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
        backgroundColor: Colors.blueGrey.shade700,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    authMode.value = authMode.value == 'email' ? 'phone' : 'email';
    isOtpSent.value = false;
  }

  // ─── Email + Password Auth ────────────────────────────────────

  /// Login with email + password
  Future<void> loginWithEmail() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'error'.tr,
        'email_password_required'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      final response = await _supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.session != null) {
        // Check if email is confirmed
        final user = response.user;
        if (user != null && user.emailConfirmedAt == null) {
          // Email not yet confirmed → send to verification screen
          Get.toNamed(
            AppRoutes.emailVerification,
            arguments: {'email': emailController.text.trim()},
          );
          return;
        }

        // Check for pending deletion request
        if (await _hasPendingDeletion()) {
          Get.offAllNamed(AppRoutes.deletionPending);
          return;
        }

        await _ensureProfile();
        Get.offAllNamed(AppRoutes.home);
      }
    } on AuthException catch (e) {
      // Supabase throws "Email not confirmed" as AuthException
      if (e.message.toLowerCase().contains('email not confirmed') ||
          e.message.toLowerCase().contains('email_not_confirmed')) {
        Get.toNamed(
          AppRoutes.emailVerification,
          arguments: {'email': emailController.text.trim()},
        );
      } else {
        Get.snackbar('error'.tr, e.message,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'something_went_wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Register with email + password
  Future<void> registerWithEmail() async {
    if (!(registerFormKey.currentState?.validate() ?? false)) return;

    try {
      isLoading.value = true;
      final response = await _supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        data: {'full_name': nameController.text.trim()},
        emailRedirectTo: 'com.dentisttracker://login-callback',
      );

      if (response.user != null) {
        if (response.user!.emailConfirmedAt == null) {
          // Needs email confirmation → show verification screen
          Get.toNamed(
            AppRoutes.emailVerification,
            arguments: {'email': emailController.text.trim()},
          );
        } else {
          // Auto-confirmed (email confirmation disabled in Supabase)
          await _ensureProfile();
          Get.offAllNamed(AppRoutes.home);
        }
      }
    } on AuthException catch (e) {
      Get.snackbar('error'.tr, e.message, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'something_went_wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Phone Auth (Twilio OTP) ──────────────────────────────────

  /// Send OTP via our backend (Twilio).
  /// Disabled when [AppConstants.isPhoneAuthEnabled] is false.
  Future<void> sendPhoneOtp() async {
    if (!AppConstants.isPhoneAuthEnabled) {
      Get.snackbar(
        'phone_auth_coming_soon_title'.tr,
        'phone_auth_coming_soon_desc'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final phone = phoneController.text.trim();
    if (phone.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'phone_invalid'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/api/auth/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        isOtpSent.value = true;
        Get.snackbar(
          'success'.tr,
          'otp_sent'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'error'.tr,
          body['error'] ?? 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'something_went_wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Verify OTP via our backend, receive session tokens.
  /// Disabled when [AppConstants.isPhoneAuthEnabled] is false.
  Future<void> verifyPhoneOtp() async {
    if (!AppConstants.isPhoneAuthEnabled) return;
    if (otpController.text.trim().isEmpty) return;

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/api/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phoneController.text.trim(),
          'code': otpController.text.trim(),
          'full_name': nameController.text.trim(),
        }),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        final session = body['session'];
        await _supabase.auth.setSession(session['refresh_token']);
        await _ensureProfile();
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar(
          'error'.tr,
          body['error'] ?? 'something_went_wrong'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'something_went_wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Register with phone — same flow, send OTP first
  Future<void> registerWithPhone() async {
    if (!AppConstants.isPhoneAuthEnabled) {
      Get.snackbar(
        'phone_auth_coming_soon_title'.tr,
        'phone_auth_coming_soon_desc'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!(registerFormKey.currentState?.validate() ?? false)) return;
    await sendPhoneOtp();
  }

  // ─── Profile & Session ────────────────────────────────────────

  /// Ensure profile row exists after auth
  Future<void> _ensureProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    final existing = await _supabase
        .from('profiles')
        .select('id')
        .eq('id', user.id)
        .maybeSingle();

    if (existing == null) {
      await _supabase.from('profiles').insert({
        'id': user.id,
        'email': user.email,
        'phone': user.phone,
        'full_name': user.userMetadata?['full_name'] ?? '',
        'revenue_percentage': 100.0,
        'preferred_language': Get.locale?.languageCode ?? 'en',
        'is_active': true,
      });
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'something_went_wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Listen to auth state changes (called from main).
  /// Skips navigation when the splash screen is handling initial routing
  /// to prevent double-navigation race conditions.
  void setupAuthListener() {
    _supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      final currentRoute = Get.currentRoute;

      // Don't navigate if splash is still the active route —
      // splash_view._checkAuth() handles the initial navigation.
      if (currentRoute == AppRoutes.splash) return;

      if (event == AuthChangeEvent.signedIn) {
        // Check for pending deletion before allowing access
        if (await _hasPendingDeletion()) {
          Get.offAllNamed(AppRoutes.deletionPending);
          return;
        }
        await _ensureProfile();
        Get.offAllNamed(AppRoutes.home);
      } else if (event == AuthChangeEvent.signedOut) {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }

  /// Returns true if the current user has a pending deletion request.
  Future<bool> _hasPendingDeletion() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final result = await _supabase
          .from('account_deletion_requests')
          .select('id')
          .eq('user_id', userId)
          .eq('status', 'pending')
          .maybeSingle();

      return result != null;
    } catch (e) {
      debugPrint('[AuthController] Deletion check failed: $e');
      return false; // Don't block login if check fails
    }
  }

  /// Static helper for splash screen to check deletion status.
  static Future<bool> checkPendingDeletion() async {
    try {
      final client = Supabase.instance.client;
      final userId = client.auth.currentUser?.id;
      if (userId == null) return false;

      final result = await client
          .from('account_deletion_requests')
          .select('id')
          .eq('user_id', userId)
          .eq('status', 'pending')
          .maybeSingle();

      return result != null;
    } catch (e) {
      debugPrint('[AuthController] Static deletion check failed: $e');
      return false;
    }
  }
}
