import 'package:elevare_ars/screens/feeds/widgets/profile_card.dart';
import 'package:elevare_ars/screens/feeds/widgets/simple_menu.dart';
import 'package:flutter/material.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          // ✅ safer than Column alone (scrolls if needed)
          padding: const EdgeInsets.all(0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfileCard(),
              const SizedBox(height: 12),
              SimpleMenuCard(),
            ],
          ),
        ),
      ),
    );
  }
}
