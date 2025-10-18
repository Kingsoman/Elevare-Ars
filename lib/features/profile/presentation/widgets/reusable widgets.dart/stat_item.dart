import 'package:flutter/material.dart';

/// Stat item for sidebar
class StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).primaryColor),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
