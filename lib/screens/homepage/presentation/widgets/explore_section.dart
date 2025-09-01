// widgets/explore_section.dart
import 'package:flutter/material.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: const Color(0xFFF5F5F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Explore top Elevare Ars content",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: const [
              Chip(label: Text("AI & Careers")),
              Chip(label: Text("Mentorship")),
              Chip(label: Text("Project Management")),
              Chip(label: Text("Productivity")),
              Chip(label: Text("Leadership")),
              Chip(label: Text("Future Skills")),
            ],
          ),
        ],
      ),
    );
  }
}
