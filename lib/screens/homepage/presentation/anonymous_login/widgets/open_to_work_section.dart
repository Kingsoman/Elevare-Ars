import 'package:elevare_ars/core/config/responsive%20layout/response_layout.dart';
import 'package:flutter/material.dart';

class OpenToWorkSection extends StatelessWidget {
  const OpenToWorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      centerColumn: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "Let the right people know you’re open to work",
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "With Elevare Ars Open-to-Work, you can privately tell recruiters or publicly share with the community that you’re looking for new opportunities.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Image.asset("assets/image/groupmentorship.png", fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
