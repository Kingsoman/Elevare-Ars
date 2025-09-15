import 'package:flutter/material.dart';

/// Right: trending topics
class TrendingCard extends StatelessWidget {
  TrendingCard({super.key});
  final trends = [
    'AI in Healthcare',
    'Portfolio Tips',
    'Interview Prep',
    'UX Design',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trending', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            ...trends.map(
              (t) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, size: 18),
                    SizedBox(width: 8),
                    Expanded(child: Text(t)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
