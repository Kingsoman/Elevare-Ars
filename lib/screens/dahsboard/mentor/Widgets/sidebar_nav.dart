import 'package:flutter/material.dart';

class SidebarNav extends StatelessWidget {
  const SidebarNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Elevate Ars",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(),

            // Menu items
            _buildNavItem(Icons.dashboard, "Dashboard", true),
            _buildNavItem(Icons.group, "My Mentees", false),
            _buildNavItem(Icons.calendar_today, "Availability", false),
            _buildNavItem(Icons.message, "Messages", false),
            _buildNavItem(Icons.book, "Resources", false),

            const Spacer(),

            _buildNavItem(Icons.settings, "Settings", false),
            _buildNavItem(Icons.logout, "Log Out", false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool active) {
    return ListTile(
      leading: Icon(icon, color: active ? Colors.blue : null),
      title: Text(
        label,
        style: TextStyle(
          color: active ? Colors.blue : null,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
