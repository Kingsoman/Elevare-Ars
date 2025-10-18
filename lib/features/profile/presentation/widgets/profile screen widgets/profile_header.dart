import 'package:elevare_ars/core/utils/format_date.dart';
import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:elevare_ars/features/mentorship/provider/mentorship_provider.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/student_profile.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/sections/profile%20header%20widgets/profile_action_buttons.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/sections/profile%20header%20widgets/profile_avatar.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/sections/profile%20header%20widgets/profile_banner.dart';
import 'package:elevare_ars/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Twitter/X-style profile header:
/// - Banner on top
/// - Avatar overlaps banner
/// - Action buttons (Follow + Message) top-right of avatar area
/// - Uses followStatsProvider to fetch follower/following counts
class ProfileHeaderSection extends ConsumerWidget {
  final dynamic profile;
  final bool isOwnProfile; // null => viewing current user

  const ProfileHeaderSection({
    super.key,
    required this.profile,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isOwnProfile = ref.read(isOwnProfileProvider(profile.id));

    // Use followRelationshipProvider for follow state if needed by FollowButton.
    // Use followStatsProvider to display follower/following counts.
    final statsAsync = ref.watch(followStatsProvider(profile.id));

    // NOTE: FollowButton internally reads followRelationshipProvider/profile id.
    // We keep the top-right action composed of FollowButton + Message.
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const ProfileBanner(),
            // Positioned avatar (center-left)
            Positioned(
              left: 16,
              bottom: -40,
              child: ProfileAvatar(
                avatarUrl: profile.avatarUrl,
                initials: profile.initials,
              ),
            ),
          ],
        ),
        SizedBox(height: !isOwnProfile ? 8 : 48), // space for avatar overlap
        if (!isOwnProfile)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProfileActionButtons(profile: profile),
          ),

        // Name, bio, role, meta
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full name
              Row(
                children: [
                  Text(
                    profile.fullName,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  if (profile is MentorProfile &&
                      (profile as MentorProfile).isVerified) ...[
                    const SizedBox(width: 4),
                    Icon(Icons.verified, size: 16, color: Colors.blue),
                  ],
                ],
              ),

              const SizedBox(height: 6),

              // Bio
              Text(
                profile.bio?.isNotEmpty == true ? profile.bio! : 'No bio yet',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.85),
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 12),

              // Role / Education line
              if (profile is MentorProfile)
                Row(
                  children: [
                    const Icon(
                      Icons.work_outline,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      (profile as MentorProfile).roleTitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                )
              else if (profile is StudentProfile)
                Row(
                  children: [
                    const Icon(
                      Icons.school_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      (profile as StudentProfile).educationLevel ?? 'Student',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 12),

              // Location + Join date (wrap for responsiveness)
              Wrap(
                spacing: 16,
                runSpacing: 6,
                children: [
                  if (profile.country != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          profile.country!,
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  if (profile.createdAt != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formatJoinedDate(profile.createdAt!),
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Followers / Following — read from provider
              // Followers / Following + Mentorship stats
              statsAsync.when(
                loading: () => Row(
                  children: [
                    ShimmerLoading.rectangular(width: 60, height: 16),
                    const SizedBox(width: 12),
                    ShimmerLoading.rectangular(width: 60, height: 16),
                  ],
                ),
                error: (_, __) => Row(
                  children: const [
                    Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                    Text('Following'),
                    SizedBox(width: 16),
                    Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                    Text('Followers'),
                  ],
                ),
                data: (stats) {
                  final followers = stats['followers'] ?? 0;
                  final following = stats['following'] ?? 0;

                  final mentorshipCountAsync = ref.watch(
                    mentorMenteeCountProvider(profile.id),
                  );

                  return Row(
                    children: [
                      Text(
                        '$following',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 6),
                      const Text('Following'),
                      const SizedBox(width: 16),
                      Text(
                        '$followers',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 6),
                      const Text('Followers'),
                      const SizedBox(width: 16),
                      mentorshipCountAsync.when(
                        loading: () =>
                            ShimmerLoading.rectangular(width: 60, height: 16),
                        error: (_, __) => const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '0',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 6),
                            Text('Mentees'),
                          ],
                        ),
                        data: (count) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$count',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              profile.role == "student" ? 'Mentors' : 'Mentees',
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
