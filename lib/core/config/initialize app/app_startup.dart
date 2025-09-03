import 'package:elevare_ars/core/config/responsive%20layout/check_platform_device.dart';
import 'package:elevare_ars/screens/onboarding/domain/onboarding_manager.dart';
import 'package:flutter/widgets.dart';

/// Global variable to tell the app whether to show onboarding
late bool showOnboarding;

/// Call this before runApp()
Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // default to skipping onboarding
  showOnboarding = false;

  // Only check onboarding on mobile
  if (PlatformHelper.isMobile) {
    final hasSeen = await OnboardingManager.hasSeenOnboarding();
    showOnboarding = !hasSeen;
  }
}
