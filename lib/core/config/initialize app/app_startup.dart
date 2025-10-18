import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Global variable to tell the app whether to show onboarding
late bool showOnboarding;

/// Call this before runApp()
Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLightMode = prefs.getBool(themeModeKey) ?? true;
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
    authOptions: FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
  );
  // try {
  //   await Supabase.instance.client.auth.refreshSession();
  // } catch (e) {
  //   // If refresh fails, sign out to clear invalid session
  //   debugPrint('Session refresh failed, clearing session: $e');
  //   await Supabase.instance.client.auth.signOut();
  // }
}
