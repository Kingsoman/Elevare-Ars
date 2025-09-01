import 'package:elevare_ars/core/config/responsive%20layout/response_layout.dart';
import 'package:flutter/material.dart';

class JobSection extends StatelessWidget {
  const JobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      centerColumn: Container(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          children: [
            Text(
              "Find the right job or internship for you",
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
                Chip(label: Text("Engineering")),
                Chip(label: Text("Design")),
                Chip(label: Text("Business Development")),
                Chip(label: Text("Marketing")),
                Chip(label: Text("Human Resources")),
                Chip(label: Text("Data Science")),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text("Post a job")),
          ],
        ),
      ),
    );
  }
}
