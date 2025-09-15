import 'package:elevare_ars/core/config/initialize%20app/app_startup.dart';
import 'package:elevare_ars/core/config/routes/app_route_config.dart';
import 'package:elevare_ars/core/config/themes/apptheme.dart';
import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late bool hasSeenOnboardingGlobal;
void main() async {
  await initializeApp();

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider); //
    return MaterialApp.router(
      routerConfig: MyAppRoutes().appRouter,
      debugShowCheckedModeBanner: false,
      title: "Elevare Ars",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: !isDarkMode ? ThemeMode.light : ThemeMode.dark,
      // home: showOnboarding
      //     ? const OnboardingScreen()
      //     : (PlatformHelper.isMobile ? LoginPage() : Feeds()),
    );
  }
}
