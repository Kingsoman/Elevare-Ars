import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:flutter/material.dart';

class ProfileUserTileShimmer extends StatelessWidget {
  const ProfileUserTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    //show 3 shimmer user rows (avatar + text + button)
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                      ShimmerLoading.rectangular(width: 200, height: 14),
                      SizedBox(height: 6),
                      ShimmerLoading.rectangular(width: 140, height: 12),
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
      ),
    );
  }
}
