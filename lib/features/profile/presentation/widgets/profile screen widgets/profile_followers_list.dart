import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile%20shimmer/profile_user_tile_shimmer.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile_user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileFollowersList extends ConsumerWidget {
  final String profileId;

  const ProfileFollowersList({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followersAsync = ref.watch(followersListProvider(profileId));

    return followersAsync.when(
      loading: () => ProfileUserTileShimmer(),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (followers) {
        if (followers.isEmpty) {
          return const Center(child: Text('No followers yet'));
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          itemCount: followers.length,
          itemBuilder: (context, index) {
            final user = followers[index];
            return ProfileUserTile(profile: user);
          },
        );
      },
    );
  }
}
