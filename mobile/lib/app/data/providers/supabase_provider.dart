import 'package:supabase_flutter/supabase_flutter.dart';

/// Centralized Supabase client access.
class SupabaseProvider {
  SupabaseProvider._();

  static SupabaseClient get client => Supabase.instance.client;

  static GoTrueClient get auth => client.auth;

  static User? get currentUser => auth.currentUser;

  static String? get userId => currentUser?.id;

  /// Get a reference to a table
  static SupabaseQueryBuilder from(String table) => client.from(table);

  /// Get a reference to the storage bucket
  static StorageFileApi get storage =>
      client.storage.from('patient-files');

  /// Call an RPC function
  static Future<dynamic> rpc(String fn, {Map<String, dynamic>? params}) =>
      client.rpc(fn, params: params);
}
