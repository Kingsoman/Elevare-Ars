// lib/repositories/profile_repository.dart
// ============================================
// ProfileRepository handles all profile-related
// database interactions safely using Supabase.
// It respects the backend RLS policies and uses
// clean, production-grade error handling.
// ============================================

import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  // ✅ Safely get the Supabase client instance from SupabaseService
  SupabaseClient get _client => Supabase.instance.client;

  // ✅ Get current user safely
  User? get _currentUser => Supabase.instance.client.auth.currentUser;

  // ---------------------------------------------------------------------------
  // Fetch a user's profile by their ID
  // RLS: Authenticated users can view all profiles
  // ---------------------------------------------------------------------------
  Future<Map<String, dynamic>?> getProfileById(String userId) async {
    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      return response;
    } on PostgrestException catch (e) {
      throw Exception('Database error while fetching profile: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while fetching profile: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Fetch the currently logged-in user's profile
  // ---------------------------------------------------------------------------
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    final user = _currentUser;
    if (user == null) throw Exception('No logged-in user found');

    return getProfileById(user.id);
  }

  // ---------------------------------------------------------------------------
  // Update current user's profile
  // RLS: Authenticated users can update ONLY their own profile
  // ---------------------------------------------------------------------------
  Future<void> updateProfile(Map<String, dynamic> updates) async {
    final user = _currentUser;
    if (user == null) throw Exception('No logged-in user found');

    try {
      final response = await _client
          .from('profiles')
          .update(updates)
          .eq('id', user.id)
          .select(); // ✅ Return data to verify update success

      if (response.isEmpty) {
        throw Exception('Failed to update profile: no data returned');
      }
    } on PostgrestException catch (e) {
      throw Exception('Database error while updating profile: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while updating profile: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Delete current user's profile
  // RLS: Authenticated users can delete ONLY their own profile
  // ---------------------------------------------------------------------------
  Future<void> deleteProfile() async {
    final user = _currentUser;
    if (user == null) throw Exception('No logged-in user found');

    try {
      await _client.from('profiles').delete().eq('id', user.id);
    } on PostgrestException catch (e) {
      throw Exception('Database error while deleting profile: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while deleting profile: $e');
    }
  }
}
