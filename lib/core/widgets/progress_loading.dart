import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressLoading extends ConsumerWidget {
  const ProgressLoading({super.key, required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeAlign: 1,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
