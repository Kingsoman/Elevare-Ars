// PROFILE STATS SIDEBAR

import 'package:elevare_ars/core/utils/format_date.dart';
import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile%20shimmer/profile_sidebar_shimmer.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/reusable%20widgets.dart/stat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Sidebar showing profile statistics
/// Displays: Followers, Following, Skills count, etc.
class ProfileStatsSidebar extends ConsumerWidget {
  final BaseProfile profile;

  const ProfileStatsSidebar({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get follow stats for this profile
    final followStatsAsync = ref.watch(followStatsProvider(profile.id));

    return Column(
      children: [
        // Stats card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Stats',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),

                // Follow stats (with loading state)
                followStatsAsync.when(
                  loading: () => const ProfileStatsSidebarShimmer(),
                  error: (_, __) => const Text(
                    'Error loading stats',
                    style: TextStyle(color: Colors.grey),
                  ),
                  data: (stats) {
                    return Column(
                      children: [
                        // Followers count
                        StatItem(
                          icon: Icons.people,
                          label: 'Followers',
                          value: stats['followers'].toString(),
                        ),
                        const Divider(height: 24),

                        // Following count
                        StatItem(
                          icon: Icons.person_add,
                          label: 'Following',
                          value: stats['following'].toString(),
                        ),

                        // Mentor-specific: Mentees count
                        if (profile is MentorProfile) ...[
                          const Divider(height: 24),
                          StatItem(
                            icon: Icons.school,
                            label: 'Mentees',
                            value: (profile as MentorProfile).menteeCount
                                .toString(),
                          ),
                        ],
                      ],
                    );
                  },
                ),

                const Divider(height: 24),

                // Skills count
                StatItem(
                  icon: Icons.construction,
                  label: 'Skills',
                  value: profile.skills.length.toString(),
                ),

                const Divider(height: 24),

                // Interests count
                StatItem(
                  icon: Icons.favorite,
                  label: 'Interests',
                  value: profile.interests.length.toString(),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Member since card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Member Since',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  profile.createdAt != null
                      ? formatJoinedDate(profile.createdAt!)
                      : 'Recently joined',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
