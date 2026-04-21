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
        await _ensureProfile();
        Get.offAllNamed(AppRoutes.home);
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
        // Check if email confirmation is required
        if (response.user!.emailConfirmedAt == null) {
          Get.snackbar(
            'check_email'.tr,
            'confirm_email_sent'.tr,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
          );
        } else {
          // Auto-confirmed (if Supabase has confirm email disabled)
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

  /// Send OTP via our backend (Twilio)
  Future<void> sendPhoneOtp() async {
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

  /// Verify OTP via our backend, receive session tokens
  Future<void> verifyPhoneOtp() async {
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

  /// Listen to auth state changes (called from main)
  void setupAuthListener() {
    _supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        await _ensureProfile();
        Get.offAllNamed(AppRoutes.home);
      } else if (event == AuthChangeEvent.signedOut) {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }
}
