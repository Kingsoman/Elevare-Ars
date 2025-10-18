import 'package:elevare_ars/core/global%20providers/supabase_providers.dart';
import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/features/follow/presentation/screens/follow_button.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileUserTile extends ConsumerWidget {
  final BaseProfile profile;

  const ProfileUserTile({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.read(currentUserIdProvider);
    final isOwnProfile = currentUserId == profile.id;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        // Avatar with navigation
        leading: GestureDetector(
          onTap: () => context.pushNamed(
            MyAppRouteConstant.profileRouteName,
            pathParameters: {'userId': profile.id},
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundImage: profile.avatarUrl != null
                ? NetworkImage(profile.avatarUrl!)
                : null,
            child: profile.avatarUrl == null
                ? Text(
                    profile.initials,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                : null,
          ),
        ),

        // Name & role
        title: Row(
          children: [
            Flexible(
              child: Text(
                profile.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (profile is MentorProfile &&
                (profile as MentorProfile).isVerified) ...[
              const SizedBox(width: 4),
              const Icon(Icons.verified, size: 16, color: Colors.blue),
            ],
          ],
        ),
        subtitle: Text(
          profile is MentorProfile
              ? (profile as MentorProfile).roleTitle
              : 'Student',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12),
        ),

        // 🫱 Follow button (or none if own profile)
        trailing: isOwnProfile ? null : FollowButton(profile: profile),

        // Entire tile navigates to profile
        onTap: () => context.pushNamed(
          MyAppRouteConstant.profileRouteName,
          pathParameters: {'userId': profile.id},
        ),
      ),
    );
  }
}
