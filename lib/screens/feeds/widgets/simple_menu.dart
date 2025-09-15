import 'package:flutter/material.dart';

/// Simple left menu
class SimpleMenuCard extends StatelessWidget {
  SimpleMenuCard({super.key});
  final items = [
    {'icon': Icons.bookmark_border, 'label': 'My Courses'},
    {'icon': Icons.event_note, 'label': 'Events'},
    {'icon': Icons.group_outlined, 'label': 'Groups'},
    {'icon': Icons.analytics_outlined, 'label': 'Insights'},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: items.map((it) {
          return ListTile(
            leading: Icon(it['icon'] as IconData),
            title: Text(it['label'] as String, style: TextStyle(fontSize: 14)),
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }
}
