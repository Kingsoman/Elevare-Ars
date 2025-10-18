// lib/features/profile/presentation/widgets/shimmers/profile_stats_sidebar_shimmer.dart

import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:flutter/material.dart';

/// Shimmer skeleton for the Profile Stats Sidebar
/// Used while stats, skills, and interests are loading.
class ProfileStatsSidebarShimmer extends StatelessWidget {
  const ProfileStatsSidebarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Stats Card shimmer
        Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title

                // Followers
                ShimmerLoading.rectangular(width: double.infinity, height: 25),
                const SizedBox(height: 12),

                // Following
                ShimmerLoading.rectangular(width: double.infinity, height: 25),
                const SizedBox(height: 12),

                // Mentees (mentor-specific section placeholder)
                ShimmerLoading.rectangular(width: double.infinity, height: 25),
                const Divider(height: 24),

                // Skills
                ShimmerLoading.rectangular(width: double.infinity, height: 25),
                const Divider(height: 24),

                // Interests
                ShimmerLoading.rectangular(width: double.infinity, height: 25),
              ],
            ),
          ),
        ),

        // Member Since Card shimmer
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading.rectangular(width: 120, height: 14),
                const SizedBox(height: 12),
                ShimmerLoading.rectangular(width: 100, height: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
