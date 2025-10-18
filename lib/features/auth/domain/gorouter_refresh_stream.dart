import 'dart:async';
import 'package:flutter/foundation.dart';

/// Custom Listenable to let GoRouter refresh when the auth state changes
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners(); // tell GoRouter to rebuild
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
