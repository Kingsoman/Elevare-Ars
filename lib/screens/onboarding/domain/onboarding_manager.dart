import 'package:shared_preferences/shared_preferences.dart';

class OnboardingManager {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool?> checkOnboardingView() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('seenOnboardingPage');
  }
}
