import 'package:flutter/material.dart';

class MenteeResponseCard extends StatelessWidget {
  const MenteeResponseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Respond to Mentees",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            _buildMenteeItem(
              "Olivia Rhye",
              "Hi Dr. Grant, I had a follow-up question about our last session...",
              "2h ago",
              "Reply",
            ),

            const Divider(),

            _buildMenteeItem(
              "New Mentee Request",
              "Leo Martinez is interested in AI & Machine Learning.",
              "1d ago",
              "View",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenteeItem(
    String name,
    String message,
    String time,
    String action,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),

      leading: const CircleAvatar(
        backgroundImage: AssetImage("assets/image/logo_icon.png"),
      ),
      title: Text(name),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
