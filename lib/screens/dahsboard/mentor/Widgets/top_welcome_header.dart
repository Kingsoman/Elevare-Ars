import 'package:flutter/material.dart';

class TopWelcomeHeader extends StatelessWidget {
  const TopWelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome Back, Dr. Grant!",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          "Here's your mentoring dashboard overview.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
