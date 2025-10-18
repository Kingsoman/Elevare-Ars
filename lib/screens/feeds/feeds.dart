import 'package:elevare_ars/core/config/themes/darkmode_switch_widget.dart';
import 'package:elevare_ars/core/widgets/menu/side_menu.dart';
import 'package:elevare_ars/core/widgets/navigationbar/bottom_navbar.dart';
import 'package:elevare_ars/core/widgets/navigationbar/mobile_drawer.dart';
import 'package:elevare_ars/core/widgets/navigationbar/navbar_responsive_helper.dart';
import 'package:elevare_ars/core/widgets/navigationbar/top_navbar.dart';
import 'package:elevare_ars/features/follow/presentation/widgets/who_to_follow_card.dart';
import 'package:elevare_ars/features/profile/presentation/screens/profile_card.dart';
import 'package:elevare_ars/screens/feeds/widgets/create_postcard.dart';
import 'package:elevare_ars/screens/feeds/widgets/feedlist.dart';
import 'package:elevare_ars/features/mentorship/presentation/screens/mentorship_request_card.dart';
import 'package:elevare_ars/screens/feeds/widgets/session_request_card.dart';
import 'package:elevare_ars/screens/feeds/widgets/trending_card.dart';
import 'package:elevare_ars/screens/homepage/presentation/anonymous_login/home.dart';
import 'package:flutter/material.dart';
import 'package:elevare_ars/core/config/responsive%20layout/responsive_layout.dart';

class Feeds extends StatelessWidget {
  const Feeds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNav(),
      bottomNavigationBar: ResponsiveHelper.isMobile(context)
          ? BottomNav()
          : null,
      drawer: ResponsiveHelper.isMobile(context) ? MobileDrawer() : null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ResponsiveLayout(
            leftColumn: !ResponsiveHelper.isMobile(context)
                ? Column(
                    children: [
                      ProfileCard(),
                      SizedBox(height: 16),
                      SideMenu(),
                      ThemeSwitchTile(),
                      ListTile(
                        title: Text(
                          'go to mentor screen',
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
            centerColumn: Column(
              children: [
                if (!ResponsiveHelper.isMobile(context) ||
                    !ResponsiveHelper.isTablet(context))
                  CreatePostCard(),
                SizedBox(height: 12),
                FeedList(),
              ],
            ),
            rightColumn: Column(
              children: [
                SessionRequestsCard(),
                SizedBox(height: 12),
                MentorshipRequestsCard(),
                SizedBox(height: 12),
                WhoToFollowCard(),
                SizedBox(height: 12),
                TrendingCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
