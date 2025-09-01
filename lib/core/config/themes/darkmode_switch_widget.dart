import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitchTile extends ConsumerWidget {
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightMode = ref.watch(themeProvider);
    final notifier = ref.read(themeProvider.notifier);

    return ListTile(
      leading: const Icon(Icons.brightness_6),
      title: const Text('Dark Mode'),
      trailing: Switch(
        value: isLightMode,
        onChanged: (value) {
          notifier.setTheme(value);
        },
      ),
    );
  }
}
