import 'package:flutter/material.dart';

class GamesSection extends StatelessWidget {
  const GamesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Keep your mind sharp with games",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Take a break and connect with your network through fun, quick games.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Icon(Icons.gamepad, size: 50, color: Colors.blue),
        ],
      ),
    );
  }
}
