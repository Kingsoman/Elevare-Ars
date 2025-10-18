import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = Provider<SupabaseClient>((_) {
  return Supabase.instance.client;
});

final currentUserProvider = Provider((ref) {
  final supabse = ref.read(supabaseProvider);
  return supabse.auth.currentUser;
});

final currentUserIdProvider = Provider((ref) {
  final supabse = ref.read(supabaseProvider);
  return supabse.auth.currentUser?.id;
});

// 1. Change the Provider type from <bool> to <String>
final currentUserMetaDataRoleProvider = Provider<String>((ref) {
  final supabse = ref.read(supabaseProvider);

  // Safely attempt to read the 'role' as a String.
  final role = supabse.auth.currentUser?.userMetadata?['role'] as String?;

  // 2. Use the null-aware operator (??) to return a guaranteed String.
  // We default to 'Guest' or 'User' if the user is logged out or the role is missing.
  return role ?? 'User';
});
