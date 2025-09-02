import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: const Color(0xFFEEF3F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Elevare Ars © 2025"),
          const SizedBox(height: 10),
          Wrap(
            spacing: 15,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: const [
              Text("About"),
              Text("Accessibility"),
              Text("Privacy Policy"),
              Text("Terms of Use"),
              Text("Help Center"),
            ],
          ),
        ],
      ),
    );
  }
}
