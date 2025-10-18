// PROVIDERS - Type-safe profile fetching

import 'package:elevare_ars/core/global%20providers/supabase_providers.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Fetches current user's profile (returns correct type based on role)
final currentUserProfileProvider = FutureProvider.autoDispose<BaseProfile?>((
  ref,
) async {
  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser?.id;

  if (userId == null) return null;

  try {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    // Return the correct profile type based on role
    final role = ref.read(currentUserMetaDataRoleProvider) as String?;
    if (role == 'student') {
      return StudentProfile.fromJson(response);
    } else if (role == 'mentor') {
      return MentorProfile.fromJson(response);
    }
    return null;
  } catch (e) {
    debugPrint('Error fetching current user profile: $e');
    return null;
  }
});

/// Fetches any user's profile by ID
final userProfileProvider = FutureProvider.autoDispose
    .family<BaseProfile?, String>((ref, userId) async {
      final supabase = Supabase.instance.client;

      try {
        final response = await supabase
            .from('profiles')
            .select()
            .eq('id', userId)
            .single();

        final role = response['role'] as String?;
        if (role == 'student') {
          return StudentProfile.fromJson(response);
        } else if (role == 'mentor') {
          return MentorProfile.fromJson(response);
        }
        return null;
      } catch (e) {
        debugPrint('Error fetching user profile: $e');
        return null;
      }
    });

/// Check if current user is viewing their own profile
final isOwnProfileProvider = Provider.family<bool, String>((ref, profileId) {
  final currentUserId = Supabase.instance.client.auth.currentUser?.id;
  return currentUserId == profileId;
});
