import 'package:elevare_ars/core/config/responsive%20layout/check_platform_device.dart';
import 'package:elevare_ars/features/auth/domain/auth_result.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServiceRepository {
  final GoTrueClient _auth;
  SupabaseClient supabase;
  AuthServiceRepository(this._auth, this.supabase);

  // User? get currentUser => _auth.currentUser;

  //SIGN IN WITH EMAIL
  //
  //

  Future<AuthResult> signinWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null || response.session == null) {
        return AuthResult.failure(error: "An error occurred");
      }

      debugPrint(response.toString());

      return AuthResult.success(response: response);
    } on AuthException catch (e) {
      return AuthResult.failure(error: e.toString());
    } catch (e) {
      return AuthResult.failure(error: e.toString());
    }
  }

  // SIGN IN WITH APPLE
  //
  //
  Future<bool> signWithApple() async {
    try {
      return await _auth.signInWithOAuth(OAuthProvider.apple);
      // Check if sign-in was successful
    } catch (e) {
      return false;
    }
  }

  // SIGN IN WITH GOOGLE
  Future<AuthResult> signInWithGoogle() async {
    try {
      final response = await _auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: PlatformHelper.isWeb
            ? "http://localhost:3000" // Redirect to your app after OAuth
            : null,
      );

      if (response) {
        // For web, the user will be redirected automatically
        // For mobile, we return success
        return AuthResult.success(
          response: null,
        ); // Adjust based on your AuthResult structure
      } else {
        return AuthResult.failure(error: "Google sign-in failed");
      }
    } on AuthException catch (e) {
      return AuthResult.failure(error: e.message);
    } catch (e) {
      return AuthResult.failure(error: e.toString());
    }
  }

  //SIGNUP WITH EMAIL
  //
  //
  Future<AuthResult> signUpWithEmailPassword({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
  }) async {
    try {
      final response = await _auth.signUp(
        email: email,
        password: password,
        data: {
          'first_name': firstname,
          'last_name': lastname,
          'hasSeenGetStartedPage': false,
        },
      );

      if (response.user == null) {
        return AuthResult.failure(error: "Signup failed. Please try again.");
      }

      return AuthResult.success(response: response);
    } on AuthException catch (e) {
      return AuthResult.failure(error: e.toString());
    } catch (e) {
      return AuthResult.failure(error: e.toString());
    }
  }

  //SIGNUP WITH APPLE
  //
  //

  //SIGNUP WITH GOOGLE
  //
  //

  //SIGN OUT
  //
  //

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } on AuthException catch (e) {
      return e.message;
    }
  }
}
