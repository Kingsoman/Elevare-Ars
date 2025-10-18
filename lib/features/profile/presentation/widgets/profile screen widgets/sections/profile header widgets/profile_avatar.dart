import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileAvatar extends ConsumerWidget {
  final String? avatarUrl;
  final String initials;

  const ProfileAvatar({
    super.key,
    required this.avatarUrl,
    required this.initials,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(colorSchemeProvider);

    return CircleAvatar(
      radius: 42,
      backgroundColor: colorScheme.surface,
      child: CircleAvatar(
        radius: 39,
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        child: avatarUrl == null
            ? Text(
                initials,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            : null,
      ),
    );
  }
}
