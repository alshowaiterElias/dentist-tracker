import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// Formatting utilities for currency, dates, and numbers.
class Formatters {
  Formatters._();

  // ─── Currency ──────────────────────────────────────────────────────

  /// Format amount in YER: "50,000 ر.ي"
  static String currency(num amount) {
    final formatter = NumberFormat('#,##0', 'en');
    return '${formatter.format(amount)} ${AppConstants.currencySymbol}';
  }

  /// Format amount compact: "50K ر.ي"
  static String currencyCompact(num amount) {
    final formatter = NumberFormat.compact(locale: 'en');
    return '${formatter.format(amount)} ${AppConstants.currencySymbol}';
  }

  // ─── Dates ─────────────────────────────────────────────────────────

  /// Full date: "April 20, 2026"
  static String dateFullEn(DateTime date) {
    return DateFormat('MMMM d, yyyy', 'en').format(date);
  }

  /// Short date: "Apr 20, 2026"
  static String dateShortEn(DateTime date) {
    return DateFormat('MMM d, yyyy', 'en').format(date);
  }

  /// Date only: "2026-04-20"
  static String dateIso(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Day and month: "20 Apr"
  static String dateDayMonth(DateTime date) {
    return DateFormat('d MMM', 'en').format(date);
  }

  /// Month and year: "April 2026"
  static String dateMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy', 'en').format(date);
  }

  /// Relative day: "Today", "Yesterday", "Apr 20"
  static String dateRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = today.difference(target).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff == -1) return 'Tomorrow';
    return dateShortEn(date);
  }

  // ─── Numbers ───────────────────────────────────────────────────────

  /// Format with commas: "1,234"
  static String number(num value) {
    return NumberFormat('#,##0', 'en').format(value);
  }

  /// Format percentage: "60%"
  static String percentage(num value) {
    return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}%';
  }

  // ─── Phone ─────────────────────────────────────────────────────────

  /// Mask phone for display: "****1234"
  static String phoneMasked(String phone) {
    if (phone.length <= 4) return phone;
    return '${'*' * (phone.length - 4)}${phone.substring(phone.length - 4)}';
  }
}
