import 'package:elevare_ars/screens/homepage/presentation/widgets/connect_learn_section.dart';
import 'package:elevare_ars/screens/homepage/presentation/widgets/explore_section.dart';
import 'package:elevare_ars/screens/homepage/presentation/widgets/footer.dart';
import 'package:elevare_ars/screens/homepage/presentation/widgets/game_section.dart';
import 'package:elevare_ars/screens/homepage/presentation/widgets/header.dart';
import 'package:elevare_ars/screens/homepage/presentation/widgets/hero_section.dart';
import 'package:elevare_ars/screens/homepage/presentation/widgets/job_section.dart';
import 'package:elevare_ars/screens/homepage/presentation/widgets/open_to_work_section.dart';
import 'package:elevare_ars/screens/homepage/presentation/widgets/software_tool_selection.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            const HeroSection(),
            // Explore Section
            const ExploreSection(),

            // Job Section
            const JobSection(),

            // Software Tools Section
            const SoftwareToolsSection(),

            // Games Section
            const GamesSection(),

            // Open to Work Section
            const OpenToWorkSection(),

            // Connect and Learn Section
            const ConnectLearnSection(),

            const SizedBox(height: 40),

            // Footer Section
            const Footer(),
          ],
        ),
      ),
    );
  }
}
