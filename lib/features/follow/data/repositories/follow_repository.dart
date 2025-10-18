import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provider to access the follow repository
final followRepositoryProvider = Provider<FollowRepository>((ref) {
  return FollowRepository(Supabase.instance.client);
});

/// Repository that handles all follow-related database operations
/// This is where all the database queries happen
class FollowRepository {
  final SupabaseClient _client;
  FollowRepository(this._client);

  // ---------------------------------------------------------------------------
  // Follow a user
  // follower_id = current user
  // following_id = target user
  // ---------------------------------------------------------------------------
  Future<bool> followUser(String userId) async {
    try {
      final currentUserId = _client.auth.currentUser?.id;
      if (currentUserId == null || currentUserId == userId) return false;

      await _client.from('follows').insert({
        'follower_id': currentUserId,
        'following_id': userId,
      });

      return true;
    } catch (e) {
      debugPrint('Error following user: $e');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Unfollow a user
  // ---------------------------------------------------------------------------
  Future<bool> unfollowUser(String userId) async {
    try {
      final currentUserId = _client.auth.currentUser?.id;
      if (currentUserId == null) return false;

      await _client.from('follows').delete().match({
        'follower_id': currentUserId,
        'following_id': userId,
      });

      return true;
    } catch (e) {
      debugPrint('Error unfollowing user: $e');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Check if current user follows another user
  // ---------------------------------------------------------------------------
  Future<bool> isFollowing(String userId) async {
    try {
      final currentUserId = _client.auth.currentUser?.id;
      if (currentUserId == null) return false;

      final response = await _client
          .from('follows')
          .select('id')
          .eq('follower_id', currentUserId)
          .eq('following_id', userId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      debugPrint('Error checking follow status: $e');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Check if another user follows the current user
  // ---------------------------------------------------------------------------
  Future<bool> isFollowingMe(String userId) async {
    try {
      final currentUserId = _client.auth.currentUser?.id;
      if (currentUserId == null) return false;

      final response = await _client
          .from('follows')
          .select('id')
          .eq('follower_id', userId)
          .eq('following_id', currentUserId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      debugPrint('Error checking if user follows me: $e');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Get follow stats (followers & following counts)
  // Works for any user — pass profileId
  // ---------------------------------------------------------------------------
  Future<Map<String, int>> getFollowStats(String userId) async {
    try {
      final result = await _client.rpc(
        'get_follow_stats',
        params: {'user_id': userId},
      );
      return {
        'followers': result['followers_count'] ?? 0,
        'following': result['following_count'] ?? 0,
      };
    } catch (e) {
      debugPrint('Error fetching follow stats: $e');
      return {'followers': 0, 'following': 0};
    }
  }

  // ---------------------------------------------------------------------------
  // Get list of users that the given profileId is following
  // ---------------------------------------------------------------------------
  Future<List<BaseProfile>> getFollowing(String profileId) async {
    try {
      final response = await _client
          .from('follows')
          .select('following_id, profiles!follows_following_id_fkey(*)')
          .eq('follower_id', profileId);

      final list = (response as List)
          .map((item) {
            final json = item['profiles'];
            final role = json['role'] as String?;
            if (role == 'student') return StudentProfile.fromJson(json);
            if (role == 'mentor') return MentorProfile.fromJson(json);
            return null;
          })
          .whereType<BaseProfile>()
          .toList();

      return list;
    } catch (e) {
      debugPrint('Error fetching following list: $e');
      return [];
    }
  }

  // ---------------------------------------------------------------------------
  // Get list of users that follow the given profileId
  // ---------------------------------------------------------------------------
  Future<List<BaseProfile>> getFollowers(String profileId) async {
    try {
      final response = await _client
          .from('follows')
          .select('follower_id, profiles!follows_follower_id_fkey(*)')
          .eq('following_id', profileId);

      final list = (response as List)
          .map((item) {
            final json = item['profiles'];
            final role = json['role'] as String?;
            if (role == 'student') return StudentProfile.fromJson(json);
            if (role == 'mentor') return MentorProfile.fromJson(json);
            return null;
          })
          .whereType<BaseProfile>()
          .toList();

      return list;
    } catch (e) {
      debugPrint('Error fetching followers list: $e');
      return [];
    }
  }

  // ---------------------------------------------------------------------------
  // Get suggested users to follow (for current user)
  // You can improve by adding better filtering later.
  // ---------------------------------------------------------------------------
  Future<List<BaseProfile>> getSuggestedUsers({int limit = 5}) async {
    try {
      final currentUserId = _client.auth.currentUser?.id;
      if (currentUserId == null) return [];

      final response = await _client
          .from('profiles')
          .select()
          .neq('id', currentUserId)
          .limit(limit);

      final list = (response as List)
          .map((json) {
            final role = json['role'] as String?;
            if (role == 'student') return StudentProfile.fromJson(json);
            if (role == 'mentor') return MentorProfile.fromJson(json);
            return null;
          })
          .whereType<BaseProfile>()
          .toList();

      return list;
    } catch (e) {
      debugPrint('Error fetching suggested users: $e');
      return [];
    }
  }

  // ---------------------------------------------------------------------------
  // Check full relationship between current user and another user
  // ---------------------------------------------------------------------------
  Future<Map<String, bool>> getFollowRelationship(String userId) async {
    try {
      final isFollowing = await this.isFollowing(userId);
      final isFollowingMe = await this.isFollowingMe(userId);
      return {'isFollowing': isFollowing, 'isFollowingMe': isFollowingMe};
    } catch (e) {
      debugPrint('Error getting follow relationship: $e');
      return {'isFollowing': false, 'isFollowingMe': false};
    }
  }
}
