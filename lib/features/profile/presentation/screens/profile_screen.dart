import 'package:elevare_ars/core/config/responsive%20layout/responsive_layout.dart';
import 'package:elevare_ars/core/widgets/menu/side_menu.dart';
import 'package:elevare_ars/core/widgets/navigationbar/top_navbar.dart';
import 'package:elevare_ars/core/widgets/navigationbar/bottom_navbar.dart';
import 'package:elevare_ars/core/widgets/navigationbar/mobile_drawer.dart';
import 'package:elevare_ars/core/widgets/navigationbar/navbar_responsive_helper.dart';
import 'package:elevare_ars/core/config/themes/darkmode_switch_widget.dart';
import 'package:elevare_ars/features/follow/presentation/widgets/who_to_follow_card.dart';
import 'package:elevare_ars/features/profile/presentation/screens/profile_card.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile_error_page.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile_header.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile_sidebar.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile_tabs.dart';
import 'package:elevare_ars/features/profile/provider/profile_provider.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile%20shimmer/profile_screen_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends ConsumerWidget {
  final String? userId; // null = current user

  const ProfileScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = userId == null
        ? ref.watch(currentUserProfileProvider)
        : ref.watch(userProfileProvider(userId!));

    final isOwnProfile = ref.watch(
      isOwnProfileProvider(
        userId ?? Supabase.instance.client.auth.currentUser!.id,
      ),
    );

    return Scaffold(
      appBar: const TopNav(),
      bottomNavigationBar: ResponsiveHelper.isMobile(context)
          ? const BottomNav()
          : null,
      drawer: ResponsiveHelper.isMobile(context) ? const MobileDrawer() : null,
      body: profileAsync.when(
        loading: () => const ProfileScreenShimmer(),
        error: (err, stack) => ErrorView(
          error: err.toString(),
          onRetry: () {
            ref.invalidate(
              userId == null
                  ? currentUserProfileProvider
                  : userProfileProvider(userId!),
            );
          },
        ),
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Profile not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ResponsiveLayout(
              leftColumn: !ResponsiveHelper.isMobile(context)
                  ? Column(
                      children: [
                        ProfileCard(),
                        const SizedBox(height: 16),
                        SideMenu(),
                        const ThemeSwitchTile(),
                      ],
                    )
                  : null,
              centerColumn: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeaderSection(
                      profile: profile,
                      isOwnProfile: isOwnProfile,
                    ),
                    ProfileTabs(profile: profile, userId: userId),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              rightColumn: Column(
                children: [
                  ProfileStatsSidebar(profile: profile),
                  const SizedBox(height: 16),
                  WhoToFollowCard(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
