// lib/screens/onboarding/domain/onboarding_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elevare_ars/screens/onboarding%20screen/domain/onboarding_manager.dart';
import 'package:elevare_ars/core/config/responsive%20layout/check_platform_device.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider that checks if the onboarding has been seen.
/// Returns true if onboarding should be shown, false if not.
final onboardingProvider = FutureProvider<bool>((ref) async {
  if (PlatformHelper.isMobile) {
    final hasSeen = await OnboardingManager.hasSeenOnboarding();
    return !hasSeen;
    // if user has NOT seen onboarding, return true (show onboarding)
    // if they have seen it, return false (skip onboarding)
  }
  return false; // Desktop/web → skip onboarding
});

final sharedPrefProvider = Provider((ref) => SharedPreferences.getInstance());
