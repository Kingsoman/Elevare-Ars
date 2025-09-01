import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the screen width is less than 600 to determine if it's a mobile view.
    // This is a common and reliable alternative to LayoutBuilder.
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              const Icon(Icons.work, color: Colors.blue, size: 32),
              const SizedBox(width: 8),
              Text(
                "Elevare Ars",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Desktop / Tablet Navigation
          // We use an if-else statement to conditionally render the navigation.
          if (!isMobile)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text("Jobs")),
                TextButton(onPressed: () {}, child: const Text("Mentorship")),
                TextButton(onPressed: () {}, child: const Text("Projects")),
                TextButton(onPressed: () {}, child: const Text("Resources")),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: () {}, child: const Text("Sign in")),
              ],
            )
          else
            // Mobile Hamburger Menu
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onSelected: (value) {
                debugPrint("Selected: $value");
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: "jobs", child: Text("Jobs")),
                const PopupMenuItem(
                  value: "mentorship",
                  child: Text("Mentorship"),
                ),
                const PopupMenuItem(value: "projects", child: Text("Projects")),
                const PopupMenuItem(
                  value: "resources",
                  child: Text("Resources"),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(value: "signin", child: Text("Sign in")),
              ],
            ),
        ],
      ),
    );
  }
}
