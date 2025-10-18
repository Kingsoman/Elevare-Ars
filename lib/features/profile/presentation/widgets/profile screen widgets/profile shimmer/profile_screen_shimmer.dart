import 'package:elevare_ars/core/config/responsive%20layout/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      leftColumn: const _LeftSidebarShimmer(),
      centerColumn: const _CenterProfileShimmer(),
      rightColumn: const _RightSidebarShimmer(),
    );
  }
}

/// 🩶 Common shimmer wrapper
Widget _shimmer({required Widget child}) {
  return Shimmer.fromColors(
    child: child,
    baseColor: Colors.pink,
    highlightColor: Colors.white10,
  );
}

/// Left column shimmer (profile summary)
class _LeftSidebarShimmer extends StatelessWidget {
  const _LeftSidebarShimmer();

  @override
  Widget build(BuildContext context) {
    return _shimmer(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(shape: BoxShape.circle),
              ),
              const SizedBox(height: 12),
              SizedBox(height: 12, width: 100),
              const SizedBox(height: 8),
              SizedBox(height: 10, width: 80),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🧠 Center column shimmer (profile header + posts)
class _CenterProfileShimmer extends StatelessWidget {
  const _CenterProfileShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: _shimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  🖼️ Banner + Avatar Stack
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Banner
                SizedBox(height: 160, width: double.infinity),
                // Profile avatar (overlaps banner)
                Positioned(
                  bottom: -40,
                  left: 16,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 56),

            // Name + Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14, width: 120),
                  const SizedBox(height: 8),
                  SizedBox(height: 12, width: 220),
                ],
              ),
            ),
            const SizedBox(height: 16),

            //  📊Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SizedBox(height: 12, width: 80),
                  const SizedBox(width: 12),
                  SizedBox(height: 12, width: 80),
                  const SizedBox(width: 12),
                  SizedBox(height: 12, width: 80),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //  Action Buttons (Message, Request Mentorship)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 36,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Post Placeholders
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(
                  3,
                  (index) => Container(
                    height: 120,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///  Right column shimmer (suggestions / extra info)
class _RightSidebarShimmer extends StatelessWidget {
  const _RightSidebarShimmer();

  @override
  Widget build(BuildContext context) {
    return _shimmer(
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
