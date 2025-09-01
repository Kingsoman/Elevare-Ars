// widgets/connect_learn_section.dart
import 'package:flutter/material.dart';

class ConnectLearnSection extends StatelessWidget {
  const ConnectLearnSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Icon(Icons.people, size: 50, color: Colors.blue),
              const SizedBox(height: 10),
              Text(
                "Connect with people who can help",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Column(
            children: [
              const Icon(Icons.school, size: 50, color: Colors.green),
              const SizedBox(height: 10),
              Text(
                "Learn the skills you need to succeed",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
