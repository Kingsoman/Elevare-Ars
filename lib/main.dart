import 'package:elevare_ars/core/config/initialize%20app/app_startup.dart';
import 'package:elevare_ars/core/config/themes/apptheme.dart';
import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:elevare_ars/screens/onboarding/domain/onboarding_manager.dart';
import 'package:elevare_ars/screens/onboarding/presentation/onboarding_screen.dart';
import 'package:elevare_ars/screens/homepage/presentation/anonymous_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late bool hasSeenOnboardingGlobal;
void main() async {
  await initializeApp();

  // Load ONCE before app starts
  hasSeenOnboardingGlobal = await OnboardingManager.hasSeenOnboarding();
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider); //
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Elevare Ars",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: showOnboarding
          ? const OnboardingScreen()
          : const AnonymousHomepage(),
    );
  }
}
