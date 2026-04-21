import 'package:get/get.dart';

/// Form validation helpers.
class Validators {
  Validators._();

  /// Required field
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? '$fieldName ${'is_required'.tr}'
          : 'field_required'.tr;
    }
    return null;
  }

  /// Patient name: min 2 chars
  static String? name(String? value) {
    final req = required(value, 'name'.tr);
    if (req != null) return req;
    if (value!.trim().length < 2) return 'name_too_short'.tr;
    return null;
  }

  /// Phone: numeric, min 9 digits
  static String? phone(String? value) {
    final req = required(value, 'phone'.tr);
    if (req != null) return req;
    final cleaned = value!.replaceAll(RegExp(r'[\s\-\+\(\)]'), '');
    if (!RegExp(r'^\d+$').hasMatch(cleaned)) return 'phone_invalid'.tr;
    if (cleaned.length < 9) return 'phone_too_short'.tr;
    return null;
  }

  /// Email validation
  static String? email(String? value) {
    final req = required(value, 'email'.tr);
    if (req != null) return req;
    if (!GetUtils.isEmail(value!.trim())) return 'email_invalid'.tr;
    return null;
  }

  /// Password: min 6 characters
  static String? password(String? value) {
    final req = required(value, 'password'.tr);
    if (req != null) return req;
    if (value!.trim().length < 6) return 'password_too_short'.tr;
    return null;
  }

  /// Age: integer 0-120
  static String? age(String? value) {
    final req = required(value, 'age'.tr);
    if (req != null) return req;
    final age = int.tryParse(value!.trim());
    if (age == null) return 'age_invalid'.tr;
    if (age < 0 || age > 120) return 'age_out_of_range'.tr;
    return null;
  }

  /// Amount: numeric, >= 0
  static String? amount(String? value, {bool allowZero = true}) {
    final req = required(value, 'amount'.tr);
    if (req != null) return req;
    final amount = double.tryParse(value!.trim());
    if (amount == null) return 'amount_invalid'.tr;
    if (!allowZero && amount <= 0) return 'amount_must_be_positive'.tr;
    if (amount < 0) return 'amount_negative'.tr;
    return null;
  }

  /// Percentage: 0-100
  static String? percentage(String? value) {
    final req = required(value, 'percentage'.tr);
    if (req != null) return req;
    final pct = double.tryParse(value!.trim());
    if (pct == null) return 'percentage_invalid'.tr;
    if (pct < 0 || pct > 100) return 'percentage_out_of_range'.tr;
    return null;
  }

  /// Medication name: min 2 chars
  static String? medicationName(String? value) {
    final req = required(value, 'medication_name'.tr);
    if (req != null) return req;
    if (value!.trim().length < 2) return 'medication_name_too_short'.tr;
    return null;
  }
}
