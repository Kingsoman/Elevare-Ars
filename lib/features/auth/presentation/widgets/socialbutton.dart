import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? backgroundColor;

  const SocialAuthButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        side: BorderSide(color: color ?? Colors.black, width: 1.2),
        padding: const EdgeInsets.all(16), // size of circle
        backgroundColor: backgroundColor ?? Colors.transparent,
      ),
      onPressed: onPressed,
      child: Icon(icon, color: color ?? Colors.black, size: 28),
    );
  }
}
