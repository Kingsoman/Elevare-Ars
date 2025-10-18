// Section card with optional edit button
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isOwnProfile;
  final VoidCallback? onEdit;

  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    required this.isOwnProfile,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isOwnProfile && onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: onEdit,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
