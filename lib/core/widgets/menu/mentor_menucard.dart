import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Mentor-specific left menu with FontAwesome icons
class MentorMenuCard extends StatelessWidget {
  MentorMenuCard({super.key});

  final items = [
    {
      'icon': FontAwesomeIcons.calendarCheck,
      'label': 'Session Requests',
      'route': '/session-requests',
    },
    {
      'icon': FontAwesomeIcons.userPlus,
      'label': 'Mentorship Requests',
      'route': '/mentorship-requests',
    },
    {
      'icon': FontAwesomeIcons.users,
      'label': 'My Mentees',
      'route': '/mentees',
    },
    {
      'icon': FontAwesomeIcons.calendarDays,
      'label': 'Schedule',
      'route': '/schedule',
    },

    {
      'icon': FontAwesomeIcons.chartLine,
      'label': 'Insights',
      'route': '/insights',
    },
    {
      'icon': FontAwesomeIcons.bookOpen,
      'label': 'Resources',
      'route': '/resources',
    },
    {'icon': FontAwesomeIcons.gear, 'label': 'Settings', 'route': '/settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: items.map((it) {
          return ListTile(
            leading: FaIcon(it['icon'] as IconData, size: 18),
            title: Text(
              it['label'] as String,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              // 🔗 later: integrate GoRouter
              // context.go(it['route'] as String);
            },
          );
        }).toList(),
      ),
    );
  }
}
