import 'package:elevare_ars/core/config/initialize%20app/app_startup.dart';
import 'package:elevare_ars/core/global%20providers/shared_preference_provider.dart';
import 'package:elevare_ars/core/routing/routes/app_route_config.dart';
import 'package:elevare_ars/core/config/themes/apptheme.dart';
import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
void main() async {
  await initializeApp();

  usePathUrlStrategy();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: "Elevare Ars",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: !isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
  }
}
