// Follow Provider (Production-Ready)

// Handles everything related to user follow functionality:
// - Following / unfollowing actions
// - Fetching followers and following lists
// - Getting follow stats
// - Tracking relationship (isFollowing / isFollowingMe)
//
//  Safe, reactive, and null-tolerant
//    → Never crashes the UI even if Supabase fails.

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elevare_ars/features/follow/data/repositories/follow_repository.dart';
import 'package:elevare_ars/features/follow/domain/models/follow_relationship.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';

/// Logs messages in debug mode only.
/// Avoids cluttering production logs.
void _safeLog(String message) {
  if (kDebugMode) debugPrint(message);
}

//  Check if current user follows a given user

// Usage:
//   ref.watch(isFollowingProvider(targetUserId))
// Returns:
//   true if current user follows targetUserId, else false

final isFollowingProvider = FutureProvider.autoDispose.family<bool, String>((
  ref,
  userId,
) async {
  final repo = ref.watch(followRepositoryProvider);
  try {
    return await repo.isFollowing(userId);
  } catch (e, st) {
    _safeLog('Error in isFollowingProvider($userId): $e\n$st');
    return false;
  }
});

// Fetch follow stats for a specific user

// Usage:
//   ref.watch(followStatsProvider(profileId))
// Returns:
//   {'followers': 12, 'following': 8}

final followStatsProvider = FutureProvider.autoDispose
    .family<Map<String, int>, String>((ref, userId) async {
      final repo = ref.watch(followRepositoryProvider);
      try {
        return await repo.getFollowStats(userId);
      } catch (e, st) {
        _safeLog('Error in followStatsProvider($userId): $e\n$st');
        return {'followers': 0, 'following': 0};
      }
    });

// Fetch followers list for any user

// Usage:
//   ref.watch(followersListProvider(profileId))
// Returns:
//   List<BaseProfile> (people who follow this profile)

final followersListProvider = FutureProvider.autoDispose
    .family<List<BaseProfile>, String>((ref, profileId) async {
      final repo = ref.watch(followRepositoryProvider);
      try {
        return await repo.getFollowers(profileId);
      } catch (e, st) {
        _safeLog('Error in followersListProvider($profileId): $e\n$st');
        return [];
      }
    });

// Fetch following list for any user

// Usage:
//   ref.watch(followingListProvider(profileId))
// Returns:
//   List<BaseProfile> (people this user follows)

final followingListProvider = FutureProvider.autoDispose
    .family<List<BaseProfile>, String>((ref, profileId) async {
      final repo = ref.watch(followRepositoryProvider);
      try {
        return await repo.getFollowing(profileId);
      } catch (e, st) {
        _safeLog('Error in followingListProvider($profileId): $e\n$st');
        return [];
      }
    });

// Follow / Unfollow Action Notifier

// Usage:
//   final notifier = ref.read(followActionProvider.notifier);
//   await notifier.toggleFollow(userId, isFollowing);
//
// Handles the actual follow/unfollow process with
// proper async loading state.

final followActionProvider =
    StateNotifierProvider<FollowActionNotifier, AsyncValue<void>>(
      (ref) => FollowActionNotifier(ref.watch(followRepositoryProvider)),
    );

class FollowActionNotifier extends StateNotifier<AsyncValue<void>> {
  final FollowRepository _repo;
  FollowActionNotifier(this._repo) : super(const AsyncData(null));

  /// Toggles between follow and unfollow for a user.
  /// Automatically handles loading and error states.
  Future<void> toggleFollow(String userId, bool currentlyFollowing) async {
    if (state.isLoading) return; // Prevent duplicate taps
    state = const AsyncLoading();

    try {
      if (currentlyFollowing) {
        await _repo.unfollowUser(userId);
      } else {
        await _repo.followUser(userId);
      }
      state = const AsyncData(null);
    } catch (e, st) {
      _safeLog('toggleFollow($userId): $e\n$st');
      state = AsyncError(e, st);
    }
  }
}

//  Follow Relationship Provider (Reactive)

// Usage:
//   ref.watch(followRelationshipProvider(userId))
//
// Returns:
//   FollowRelationship(
//     isFollowing: true/false,
//     isFollowingMe: true/false,
//   )
//
// This keeps the UI in sync with follow state changes
// and updates reactively across screens.

final followRelationshipProvider =
    AsyncNotifierProviderFamily<
      FollowRelationshipNotifier,
      FollowRelationship,
      String
    >(FollowRelationshipNotifier.new);

class FollowRelationshipNotifier
    extends FamilyAsyncNotifier<FollowRelationship, String> {
  @override
  Future<FollowRelationship> build(String userId) async {
    final repo = ref.watch(followRepositoryProvider);

    try {
      final isFollowing = await repo.isFollowing(userId);
      final isFollowingMe = await repo.isFollowingMe(userId);
      return FollowRelationship(
        isFollowing: isFollowing,
        isFollowingMe: isFollowingMe,
      );
    } catch (e, st) {
      _safeLog('Error building followRelationship($userId): $e\n$st');
      return const FollowRelationship(isFollowing: false, isFollowingMe: false);
    }
  }

  /// Optimistic follow toggle (instant UI update)
  /// The UI updates first, and if Supabase fails,
  /// it reverts to the previous state.
  Future<void> toggleFollow() async {
    final repo = ref.read(followRepositoryProvider);
    final current = state.value;

    if (current == null) return;

    // Optimistic UI update
    final newState = current.copyWith(isFollowing: !current.isFollowing);
    state = AsyncData(newState);

    try {
      if (current.isFollowing) {
        await repo.unfollowUser(arg);
      } else {
        await repo.followUser(arg);
      }
    } catch (e, st) {
      _safeLog('toggleFollow() failed for $arg: $e\n$st');
      state = AsyncData(current); // revert if something goes wrong
    }
  }
}

//  SUGGESTED USERS PROVIDER

//// Usage: ref.watch(suggestedUsersProvider)
///// Returns: List(max 5) // Only completed profiles not already followed.
//
final suggestedUsersProvider = FutureProvider.autoDispose<List<BaseProfile>>((
  ref,
) async {
  try {
    final repo = ref.watch(followRepositoryProvider);
    return await repo.getSuggestedUsers(limit: 5);
  } catch (e, st) {
    return [];
  }
});
