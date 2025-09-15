import 'package:elevare_ars/core/config/responsive%20layout/dashboard_layouttt.dart';
import 'package:elevare_ars/screens/dahsboard/mentor/Widgets/sidebar_nav.dart';
import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardLayout(
        sidebar: const SidebarNav(),
        centerColumn: _buildCenterColumn(),
        rightColumn: _buildRightColumn(),
      ),
    );
  }

  /// 🟦 Main center column
  Widget _buildCenterColumn() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _welcomeHeader(),
        const SizedBox(height: 20),
        _upcomingSessionsCard(),
        const SizedBox(height: 20),
        _recommendedProjects(),
      ],
    );
  }

  /// 🟧 Right column (Goals + Skills)
  Widget _buildRightColumn() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_goalsCard(), const SizedBox(height: 20), _skillsCard()],
    );
  }

  // ------------------------------------------------------------
  // Components
  // ------------------------------------------------------------

  Widget _welcomeHeader() {
    return const Text(
      "Welcome Back, Olivia!\nLet's continue your journey to success.",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  /// Upcoming sessions card
  /// Upcoming sessions card (clean refactor)
  Widget _upcomingSessionsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upcoming Sessions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _sessionTile(
              title: "Career Guidance",
              subtitle: "With Mentor Jane",
              time: "Tomorrow, 3 PM",
              actionLabel: "Join",
            ),
            const Divider(),
            _sessionTile(
              title: "CV Review",
              subtitle: "With Mentor John",
              time: "Friday, 11 AM",
              actionLabel: "Join",
            ),
          ],
        ),
      ),
    );
  }

  /// A custom session row widget (instead of ListTile)
  Widget _sessionTile({
    required String title,
    required String subtitle,
    required String time,
    required String actionLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left (Text details)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(color: Colors.blue)),
              ],
            ),
          ),

          // Right (button)
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(70, 36), // compact size
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }

  Widget _recommendedProjects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recommended Projects",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _projectCard(
                title: "Redesign a Charity Website",
                category: "UX/UI Design",
                description:
                    "Apply your design skills to create a more user-friendly and engaging website.",
                tags: ["UX/UI Design", "Figma"],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _projectCard(
                title: "Customer Churn Prediction",
                category: "Data Analysis",
                description:
                    "Analyze a dataset to build a model that predicts customer churn.",
                tags: ["Python", "Data Analysis"],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _projectCard({
    required String title,
    required String category,
    required String description,
    required List<String> tags,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(category, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: tags
                  .map(
                    (t) => Chip(
                      label: Text(t),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: () {}, child: const Text("View Project")),
          ],
        ),
      ),
    );
  }

  Widget _goalsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Goals",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _goalItem("Complete 2 learning modules", true),
            _goalItem("Update skill portfolio", true),
            _goalItem("Research 1 new company", true),
            _goalItem("Message a potential mentor", false),
            _goalItem("Apply for an internship", false, crossed: true),
          ],
        ),
      ),
    );
  }

  Widget _goalItem(String text, bool done, {bool crossed = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(value: done, onChanged: (_) {}),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          decoration: crossed ? TextDecoration.lineThrough : null,
          color: done ? Colors.green : null,
        ),
      ),
    );
  }

  Widget _skillsCard() {
    final skills = [
      "Python",
      "UX/UI Design",
      "Data Analysis",
      "Figma",
      "Project Management",
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Skill Portfolio",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              children: skills
                  .map(
                    (s) => Chip(
                      label: Text(s),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {},
              child: const Text("Manage Skills"),
            ),
          ],
        ),
      ),
    );
  }
}
