import 'package:elevare_ars/core/config/responsive%20layout/dashboard_layouttt.dart';
import 'package:elevare_ars/screens/dahsboard/mentor/Widgets/availability_calendar_card.dart';
import 'package:elevare_ars/screens/dahsboard/mentor/Widgets/impact_summary_card.dart';
import 'package:elevare_ars/screens/dahsboard/mentor/Widgets/mentee_response_card.dart';
import 'package:elevare_ars/screens/dahsboard/mentor/Widgets/sidebar_nav.dart';
import 'package:elevare_ars/screens/dahsboard/mentor/Widgets/top_welcome_header.dart';
import 'package:flutter/material.dart';

class MentorDashboard extends StatelessWidget {
  const MentorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardLayout(
        sidebar: const SidebarNav(),
        centerColumn: _buildCenterContent(),
        rightColumn: const AvailabilityCalendarCard(),
      ),
    );
  }

  Widget _buildCenterContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        TopWelcomeHeader(),
        SizedBox(height: 20),
        MenteeResponseCard(),
        SizedBox(height: 20),
        ImpactSummaryCard(),
      ],
    );
  }
}
