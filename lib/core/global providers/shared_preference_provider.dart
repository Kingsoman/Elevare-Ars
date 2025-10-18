import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized');
});

// Asynchronous provider that initializes SharedPreferences only once
final sharedPrefsInstanceProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});
