import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Build error view with retry button
Widget buildErrorView(WidgetRef ref) {
  return Column(
    children: [
      const Text(
        'Failed to load suggestions',
        style: TextStyle(color: Colors.grey),
      ),
      const SizedBox(height: 8),
      TextButton(
        onPressed: () {
          // Refresh the provider to retry
          ref.invalidate(suggestedUsersProvider);
        },
        child: const Text('Retry'),
      ),
    ],
  );
}
