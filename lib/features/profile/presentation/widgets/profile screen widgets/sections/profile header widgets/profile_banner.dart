import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileBanner extends ConsumerWidget {
  const ProfileBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(colorSchemeProvider);

    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        image: const DecorationImage(
          image: AssetImage("assets/image/groupmentorship.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
