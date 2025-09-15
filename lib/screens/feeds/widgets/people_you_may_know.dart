import 'package:flutter/material.dart';

/// Right: who to follow - Simplified
class WhoToFollowCard extends StatelessWidget {
  const WhoToFollowCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.blue, Colors.orange];

    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'People you may want to follow',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 16),
            // Generate 3 suggestion items
            ...List.generate(3, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: index == 2 ? 0 : 12),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(26),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, color: colors[index]),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pro ${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Industry Mentor',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 3),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              minimumSize: Size(70, 32),
                            ),
                            child: Text(
                              'Follow',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
