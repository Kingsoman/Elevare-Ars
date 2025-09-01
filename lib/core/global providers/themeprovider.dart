import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Key to save theme mode
const _themeModeKey = 'theme_mode';

/// StateNotifier to handle theme switching and persistence
class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(true) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getBool(_themeModeKey);

    state = themeMode ?? true;
  }

  Future<void> setTheme(bool isLightMode) async {
    state = isLightMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeModeKey, state);
  }
}

/// Provider you’ll use in your app
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(),
);
