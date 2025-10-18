import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:elevare_ars/features/mentorship/provider/mentorship_provider.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowButton extends ConsumerWidget {
  final BaseProfile profile;
  const FollowButton({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relationshipAsync = ref.watch(followRelationshipProvider(profile.id));
    final notifier = ref.read(followRelationshipProvider(profile.id).notifier);

    return relationshipAsync.when(
      loading: () => ShimmerLoading.rectangular(width: 80, height: 36),
      error: (err, _) => TextButton(
        onPressed: () => notifier.toggleFollow(),
        child: const Text("Retry"),
      ),
      data: (rel) {
        final isFollowing = rel.isFollowing;
        final isFollowingMe = rel.isFollowingMe;
        // Determine button text
        String buttonText;
        if (isFollowing) {
          buttonText = 'Following';
        } else if (isFollowingMe) {
          buttonText = 'Follow back';
        } else {
          buttonText = 'Follow';
        }
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: isFollowingMe ? 0 : 0),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () async {
                await notifier.toggleFollow();
                //  Instantly refresh relevant data after following/unfollowing
                ref.invalidate(followStatsProvider(profile.id));
                ref.invalidate(mentorshipStatusProvider(profile.id));
                ref.invalidate(mentorMenteeCountProvider(profile.id));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
