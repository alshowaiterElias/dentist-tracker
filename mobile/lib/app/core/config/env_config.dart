/// Compile-time environment configuration.
///
/// Values are injected via `--dart-define` flags at build time:
///
/// ```bash
/// # Development
/// flutter run \
///   --dart-define=SUPABASE_URL=https://your-project.supabase.co \
///   --dart-define=SUPABASE_ANON_KEY=your-anon-key
///
/// # Production release
/// flutter build appbundle \
///   --dart-define=SUPABASE_URL=https://your-project.supabase.co \
///   --dart-define=SUPABASE_ANON_KEY=your-anon-key
/// ```
///
/// If no `--dart-define` values are provided, the app will throw
/// at startup with a clear error message.
class EnvConfig {
  EnvConfig._();

  /// Supabase project URL.
  /// Injected via: `--dart-define=SUPABASE_URL=https://xxx.supabase.co`
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  /// Supabase anonymous/public key.
  /// Injected via: `--dart-define=SUPABASE_ANON_KEY=eyJ...`
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  /// Validates that all required environment variables are set.
  /// Call this during app startup before any Supabase operations.
  static void validate() {
    final missing = <String>[];

    if (supabaseUrl.isEmpty) missing.add('SUPABASE_URL');
    if (supabaseAnonKey.isEmpty) missing.add('SUPABASE_ANON_KEY');

    if (missing.isNotEmpty) {
      throw StateError(
        'Missing required environment variables: ${missing.join(', ')}.\n'
        'Pass them via --dart-define flags when building:\n'
        '  flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...',
      );
    }
  }
}
