import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile%20shimmer/profile_user_tile_shimmer.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile_user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileFollowingList extends ConsumerWidget {
  final String profileId;

  const ProfileFollowingList({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // You can later switch to a provider that takes a profileId (if following someone else’s list)
    final followingsAsync = ref.watch(followingListProvider(profileId));

    return followingsAsync.when(
      loading: () => ProfileUserTileShimmer(),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (following) {
        if (following.isEmpty) {
          return const Center(child: Text('Not following anyone yet'));
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          itemCount: following.length,
          itemBuilder: (context, index) {
            final user = following[index];
            return ProfileUserTile(profile: user);
          },
        );
      },
    );
  }
}
