import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:flutter/material.dart';

/// A shimmer placeholder for the "Who to Follow" section
/// Matches your app’s dark/light theme
class WhoToFollowShimmer extends StatelessWidget {
  const WhoToFollowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // We'll show 3 shimmer user rows (avatar + text + button)
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              // Avatar shimmer
              const ShimmerLoading.circular(size: 40),
              const SizedBox(width: 12),

              // Name and bio lines
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading.rectangular(width: 120, height: 14),
                    SizedBox(height: 6),
                    ShimmerLoading.rectangular(width: 80, height: 12),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Follow button shimmer
              ShimmerLoading.rectangular(width: 70, height: 28),
            ],
          ),
        );
      }),
    );
  }
}
