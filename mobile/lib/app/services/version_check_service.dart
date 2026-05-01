import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Result of comparing the app version against remote config.
enum UpdateStatus {
  /// App is up-to-date or no config found — proceed normally.
  upToDate,

  /// A newer version exists but the current version still works.
  optionalUpdate,

  /// Current version is below the minimum — must update to continue.
  forceUpdate,
}

/// Holds the remote version config fetched from `app_config`.
class VersionInfo {
  final UpdateStatus status;
  final String currentVersion;
  final String latestVersion;
  final String minVersion;
  final String storeUrl;
  final String updateMessage;

  const VersionInfo({
    required this.status,
    required this.currentVersion,
    required this.latestVersion,
    required this.minVersion,
    required this.storeUrl,
    required this.updateMessage,
  });

  /// Default when the check fails or no config exists.
  factory VersionInfo.upToDate(String currentVersion) => VersionInfo(
        status: UpdateStatus.upToDate,
        currentVersion: currentVersion,
        latestVersion: currentVersion,
        minVersion: '0.0.0',
        storeUrl: '',
        updateMessage: '',
      );
}

/// Checks the app version against remote `app_config` in Supabase.
///
/// Usage in splash:
/// ```dart
/// final info = await VersionCheckService.check();
/// if (info.status == UpdateStatus.forceUpdate) { /* show dialog */ }
/// ```
class VersionCheckService {
  VersionCheckService._();

  /// Perform the version check against Supabase `app_config`.
  /// Returns [VersionInfo.upToDate] if the check fails (network error, etc.)
  /// so the app is never blocked by a transient failure.
  static Future<VersionInfo> check() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version; // e.g. "1.0.0"

      final data = await Supabase.instance.client
          .from('app_config')
          .select()
          .eq('id', 1)
          .maybeSingle();

      if (data == null) {
        debugPrint('[VersionCheck] No app_config row found — skipping.');
        return VersionInfo.upToDate(currentVersion);
      }

      final minVersion = data['min_version'] as String? ?? '0.0.0';
      final latestVersion = data['latest_version'] as String? ?? currentVersion;
      final forceUpdate = data['force_update'] as bool? ?? false;
      final storeUrl = data['store_url'] as String? ?? '';
      final updateMessage = data['update_message'] as String? ?? '';

      debugPrint('[VersionCheck] current=$currentVersion, '
          'min=$minVersion, latest=$latestVersion, force=$forceUpdate');

      // Determine status
      UpdateStatus status;
      if (forceUpdate && _isLowerThan(currentVersion, minVersion)) {
        status = UpdateStatus.forceUpdate;
      } else if (_isLowerThan(currentVersion, latestVersion)) {
        status = UpdateStatus.optionalUpdate;
      } else {
        status = UpdateStatus.upToDate;
      }

      return VersionInfo(
        status: status,
        currentVersion: currentVersion,
        latestVersion: latestVersion,
        minVersion: minVersion,
        storeUrl: storeUrl,
        updateMessage: updateMessage,
      );
    } catch (e) {
      debugPrint('[VersionCheck] Check failed (allowing app to proceed): $e');
      try {
        final info = await PackageInfo.fromPlatform();
        return VersionInfo.upToDate(info.version);
      } catch (_) {
        return VersionInfo.upToDate('0.0.0');
      }
    }
  }

  /// Semantic version comparison: returns true if [a] < [b].
  /// Handles versions like "1.0.0", "1.2.3", "2.0.0".
  static bool _isLowerThan(String a, String b) {
    final aParts = a.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final bParts = b.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    // Pad to 3 parts
    while (aParts.length < 3) {
      aParts.add(0);
    }
    while (bParts.length < 3) {
      bParts.add(0);
    }

    for (var i = 0; i < 3; i++) {
      if (aParts[i] < bParts[i]) return true;
      if (aParts[i] > bParts[i]) return false;
    }
    return false; // equal
  }
}
