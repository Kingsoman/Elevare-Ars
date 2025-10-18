// FILE 5: SUGGESTION ITEM WIDGET
// ============================================
// features/follow/presentation/widgets/suggestion_item.dart

import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/features/follow/domain/get_role.dart';
import 'package:elevare_ars/features/follow/presentation/screens/follow_button.dart';
import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Individual user suggestion item with follow button
/// Used inside WhoToFollowCard
class SuggestionItem extends ConsumerWidget {
  final BaseProfile profile;

  const SuggestionItem({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Follow button (shows loading/error states)
    final relationship = ref.watch(followRelationshipProvider(profile.id));

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            // Avatar (clickable - goes to profile)
            GestureDetector(
              onTap: () => context.goNamed(
                MyAppRouteConstant.profileRouteName,
                pathParameters: {'userId': profile.id},
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: profile.avatarUrl != null
                    ? NetworkImage(profile.avatarUrl!)
                    : null,
                // Show initials if no avatar
                child: profile.avatarUrl == null
                    ? Text(
                        profile.initials,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 12),

            // Name & bio (clickable - goes to profile)
            Expanded(
              child: GestureDetector(
                onTap: () => context.goNamed(
                  MyAppRouteConstant.profileRouteName,
                  pathParameters: {'userId': profile.id},
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name with verified badge (for mentors)
                    Row(
                      children: [
                        // Name
                        Flexible(
                          child: Text(
                            profile.fullName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Verified badge (only for verified mentors)
                        if (profile is MentorProfile &&
                            (profile as MentorProfile).isVerified) ...[
                          const SizedBox(width: 4),
                          Tooltip(
                            message: 'Follow user',
                            child: Icon(
                              Icons.verified,
                              size: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ],
                    ),
                    // Role/title
                    Text(
                      getRoleTitle(profile),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 5),
                    FollowButton(profile: profile),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
