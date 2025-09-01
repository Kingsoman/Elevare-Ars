import 'package:flutter/material.dart';

class SoftwareToolsSection extends StatelessWidget {
  const SoftwareToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Discover the best software tools",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: const [
              Chip(label: Text("E-learning Platforms")),
              Chip(label: Text("CRM Tools")),
              Chip(label: Text("Recruiting Software")),
              Chip(label: Text("Collaboration Tools")),
              Chip(label: Text("Video Conferencing")),
              Chip(label: Text("Cloud Solutions")),
            ],
          ),
        ],
      ),
    );
  }
}
