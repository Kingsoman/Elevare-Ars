import 'package:elevare_ars/core/config/themes/apptheme.dart';
import 'package:elevare_ars/core/global%20providers/shared_preference_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const themeModeKey = 'theme_mode';

class ThemeNotifier extends StateNotifier<bool> {
  final SharedPreferences prefs;

  ThemeNotifier(this.prefs) : super(prefs.getBool(themeModeKey) ?? true);

  Future<void> setTheme(bool isLightMode) async {
    state = isLightMode;
    await prefs.setBool(themeModeKey, isLightMode);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return ThemeNotifier(prefs);
});

final colorSchemeProvider = Provider<ColorScheme>((ref) {
  final isLightMode = ref.watch(themeProvider);
  return isLightMode
      ? AppTheme.lightTheme.colorScheme
      : AppTheme.darkTheme.colorScheme;
});
