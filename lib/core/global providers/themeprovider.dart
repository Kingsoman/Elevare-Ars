import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

/// Key to save theme mode
const _themeModeKey = 'theme_mode';

/// StateNotifier to handle theme switching and persistence
class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    // Start with false (dark theme) until loaded
    loadTheme();
  }

  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeMode = prefs.getBool(_themeModeKey);

      // If a theme was previously saved, use it
      // Otherwise default to true (light theme)
      state = themeMode ?? true;
    } catch (e) {
      // If there's an error reading preferences, default to light theme
      state = true;
    }
  }

  Future<void> setTheme(bool isLightMode) async {
    state = isLightMode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeModeKey, isLightMode);
    } catch (e) {
      // Handle potential SharedPreferences errors
      debugPrint('Failed to save theme preference: $e');
    }
  }
}

/// Provider you'll use in your app
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(),
);
