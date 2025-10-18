import 'package:supabase_flutter/supabase_flutter.dart';

class AuthResult {
  // Use a named constructor for error cases
  AuthResult.success({required this.response}) : error = null;

  // Use a named constructor for error cases
  AuthResult.failure({required this.error}) : response = null;

  // Change type from AuthResponse? to User? to focus on the signed-in user
  // OR keep AuthResponse? and use getters. Keeping AuthResponse is fine.
  final AuthResponse? response;
  final String? error;

  // Convenience property - checks for the existence of the AuthResponse
  bool get isSuccess => response != null && error == null;

  // Convenience getters for easy access to the user and session
  User? get user => response?.user;
  Session? get session => response?.session;
}
