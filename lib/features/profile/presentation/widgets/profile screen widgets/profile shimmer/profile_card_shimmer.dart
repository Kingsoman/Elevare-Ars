import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:flutter/material.dart';

/// Shimmer skeleton for profile card (used while profile data is loading)
/// Works with the reusable [ShimmerLoading] widget.
class ProfileCardShimmer extends StatelessWidget {
  const ProfileCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Banner shimmer
            ShimmerLoading.rectangular(
              width: double.infinity,
              height: 100,
              borderRadiusValue: 12,
            ),
            const SizedBox(height: 16),

            // Profile picture shimmer
            const ShimmerLoading.circular(size: 70),
            const SizedBox(height: 12),

            // Name shimmer
            ShimmerLoading.rectangular(width: 120, height: 14),
            const SizedBox(height: 8),

            // Bio shimmer
            ShimmerLoading.rectangular(width: 180, height: 12),
            const SizedBox(height: 16),

            // Button shimmer
            ShimmerLoading.rectangular(width: 100, height: 32),
          ],
        ),
      ),
    );
  }
}
