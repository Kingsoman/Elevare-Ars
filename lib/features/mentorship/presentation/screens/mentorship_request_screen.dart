import 'package:elevare_ars/core/config/themes/darkmode_switch_widget.dart';
import 'package:elevare_ars/core/global%20providers/supabase_providers.dart';
import 'package:elevare_ars/core/utils/format_date.dart';
import 'package:elevare_ars/core/widgets/menu/side_menu.dart';
import 'package:elevare_ars/core/widgets/navigationbar/bottom_navbar.dart';
import 'package:elevare_ars/core/widgets/navigationbar/mobile_drawer.dart';
import 'package:elevare_ars/core/widgets/navigationbar/navbar_responsive_helper.dart';
import 'package:elevare_ars/core/widgets/navigationbar/top_navbar.dart';
import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:elevare_ars/features/follow/presentation/widgets/who_to_follow_card.dart';
import 'package:elevare_ars/features/mentorship/provider/mentorship_provider.dart';
import 'package:elevare_ars/features/profile/presentation/screens/profile_card.dart';
import 'package:elevare_ars/screens/feeds/widgets/session_request_card.dart';
import 'package:elevare_ars/screens/feeds/widgets/trending_card.dart';
import 'package:elevare_ars/screens/homepage/presentation/anonymous_login/home.dart';
import 'package:elevare_ars/features/mentorship/presentation/screens/widgets/request_card.dart';
import 'package:flutter/material.dart';
import 'package:elevare_ars/core/config/responsive%20layout/responsive_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentorRequestsPage extends ConsumerWidget {
  const MentorRequestsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserIdProvider);
    final requestsAsync = ref.watch(incomingRequestsProvider(userId ?? ''));

    return Scaffold(
      appBar: TopNav(),
      bottomNavigationBar: ResponsiveHelper.isMobile(context)
          ? BottomNav()
          : null,
      drawer: ResponsiveHelper.isMobile(context) ? MobileDrawer() : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ResponsiveLayout(
          // 🔹 LEFT COLUMN — visible on tablet/desktop
          leftColumn: !ResponsiveHelper.isMobile(context)
              ? Column(
                  children: [
                    const ProfileCard(),
                    const SizedBox(height: 16),
                    SideMenu(),
                    const ThemeSwitchTile(),
                    ListTile(
                      title: const Text(
                        'Go to Mentor Screen',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      },
                    ),
                  ],
                )
              : null,

          // 🔹 CENTER COLUMN — main mentorship requests list
          centerColumn: requestsAsync.when(
            loading: () => ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ShimmerLoading(width: double.infinity, height: 100),
              ),
            ),
            error: (error, _) => Center(
              child: Text(
                'Error loading requests: $error',
                style: const TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),
            data: (requests) {
              if (requests.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      "No mentorship requests yet.",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                );
              }

              return Column(
                children: requests.map((req) {
                  return RequestCard(
                    name: req.menteeName ?? "Unknown",
                    timeAgo: formatTimeAgo(req.createdAt),
                    details: req.note,
                    onAccept: () async {
                      await ref.read(
                        respondToRequestProvider((req.id, true)).future,
                      );
                      ref.invalidate(incomingRequestsProvider(req.mentorId));
                    },
                    onDecline: () async {
                      await ref.read(
                        respondToRequestProvider((req.id, false)).future,
                      );
                      ref.invalidate(incomingRequestsProvider(req.mentorId));
                    },
                  );
                }).toList(),
              );
            },
          ),

          // 🔹 RIGHT COLUMN — sidebar widgets (feed cards etc.)
          rightColumn: Column(
            children: [
              const SessionRequestsCard(),
              const SizedBox(height: 12),
              const WhoToFollowCard(),
              const SizedBox(height: 12),
              TrendingCard(),
            ],
          ),
        ),
      ),
    );
  }
}
