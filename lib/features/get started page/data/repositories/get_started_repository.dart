// lib/features/getstarted/data/repositories/get_started_repository.dart

import 'package:elevare_ars/features/get%20started%20page/domain/models/onboarding_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getStartedRepositoryProvider = Provider<GetStartedRepository>((ref) {
  return GetStartedRepository(Supabase.instance.client);
});

class GetStartedRepository {
  final SupabaseClient _client;

  GetStartedRepository(this._client);

  /// Completes user onboarding by updating both auth metadata and the public.profiles table
  /// Completes user onboarding by updating both auth metadata and the public.profiles table.
  /// Ensures that metadata is only updated *after* the profile update succeeds.
  Future<bool> completeOnboarding(OnboardingProfile profile) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      // 1️⃣ Update `profiles` table first
      final profileUpdate = await _client
          .from('profiles')
          .update({
            ...profile.toJson(),
            'completed_onboarding': true,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', user.id)
          .select();

      if (profileUpdate.isEmpty) {
        throw Exception('Failed to update profile data.');
      }

      // 2️⃣ Only update auth metadata after successful profile update
      final authUpdate = await _client.auth.updateUser(
        UserAttributes(
          data: {'hasSeenGetStartedPage': true, 'role': profile.role},
        ),
      );

      if (authUpdate.user == null) {
        throw Exception('Failed to update user metadata.');
      }

      return true;
    } on AuthException catch (e) {
      throw Exception('Auth error: ${e.message}');
    } on PostgrestException catch (e) {
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error completing onboarding: $e');
    }
  }
}
