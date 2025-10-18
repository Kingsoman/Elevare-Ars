import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Navigation menu for Students
class StudentMenuCard extends StatelessWidget {
  StudentMenuCard({super.key});

  final items = [
    {
      'icon': FontAwesomeIcons.userTie,
      'label': 'Find Mentors',
      'route': '/mentors',
    },
    {
      'icon': FontAwesomeIcons.handshake,
      'label': 'Mentorship Requests',
      'route': '/mentorship-requests',
    },
    {
      'icon': FontAwesomeIcons.calendarDays,
      'label': 'My Sessions',
      'route': '/sessions',
    },
    {
      'icon': FontAwesomeIcons.bookOpen,
      'label': 'Resources',
      'route': '/resources',
    },
    {
      'icon': FontAwesomeIcons.calendarCheck,
      'label': 'Events',
      'route': '/events',
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              final route = it['route'] as String;
              // context.go(route);
            },
          );
        }).toList(),
      ),
    );
  }
}
