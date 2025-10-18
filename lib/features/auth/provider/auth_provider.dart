import 'package:elevare_ars/core/global%20providers/supabase_providers.dart';
import 'package:elevare_ars/features/auth/data/authservice.dart';
import 'package:elevare_ars/features/auth/domain/auth_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authServiceProvider = Provider((_) => Supabase.instance.client.auth);
final authService = Provider(
  (ref) => AuthServiceRepository(
    ref.read(authServiceProvider),
    ref.read(supabaseProvider),
  ),
);

final sigUpWithEmailProvider =
    FutureProvider.family<
      AuthResult,
      ({String email, String password, String firstname, String lastname})
    >((ref, params) {
      final auth = ref.read(authService);

      return auth.signUpWithEmailPassword(
        email: params.email,
        password: params.password,
        firstname: params.firstname,
        lastname: params.lastname,
      );
    });

final loginWithEmailProvider =
    FutureProvider.family<AuthResult, ({String email, String password})>((
      ref,
      params,
    ) {
      final auth = ref.read(authService);

      return auth.signinWithEmailPassword(
        email: params.email,
        password: params.password,
      );
    });

//Session Provider
final sessionProvider = StreamProvider<Session?>((ref) {
  final auth = ref.read(authServiceProvider);

  return auth.onAuthStateChange.map((event) => event.session);
});

//Sign in with Google
final signinWithGoogleProvider = FutureProvider((ref) {
  final auth = ref.read(authService);

  return auth.signInWithGoogle();
});

final currentUserProvider = Provider((ref) {
  final auth = ref.read(authServiceProvider);
  return auth.currentUser?.userMetadata?["first_name"]["last_name"];
});
