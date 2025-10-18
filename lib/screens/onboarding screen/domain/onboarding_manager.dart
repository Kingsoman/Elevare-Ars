import 'package:shared_preferences/shared_preferences.dart';

class OnboardingManager {
  static const String _keySeenOnboarding = "seenOnboardingPage";

  /// Check if onboarding has been shown before
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySeenOnboarding) ?? false;
  }

  /// Mark onboarding as completed
  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySeenOnboarding, true);
  }
}
