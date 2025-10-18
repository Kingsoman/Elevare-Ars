import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final String name;
  final String timeAgo;
  final String details;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const RequestCard({
    super.key,
    required this.name,
    required this.timeAgo,
    required this.details,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Name + Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  timeAgo,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 🔹 Details
            Text(details, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 12),

            // 🔹 Buttons
            Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: OutlinedButton(
                    onPressed: onDecline,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(80, 36),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text(
                      "Decline",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 36),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text(
                      "Accept",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
