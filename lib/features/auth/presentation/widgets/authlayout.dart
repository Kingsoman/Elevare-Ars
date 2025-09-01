import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget child; // e.g. login form
  final Widget? branding; // optional illustration/branding for desktop

  const AuthLayout({super.key, required this.child, this.branding});

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1100;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context) || isTablet(context)) {
      // Desktop/Tablet Layout: Branding Left + Form Right
      return Row(
        children: [
          Expanded(
            child:
                branding ??
                Container(
                  color: Colors.blueGrey.shade50,
                  child: const Center(
                    child: Text(
                      "Elevare Ars",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          ),
          SizedBox(
            width: 400,
            child: Center(
              child: Padding(padding: const EdgeInsets.all(32.0), child: child),
            ),
          ),
        ],
      );
    }

    // Mobile Layout: form centered
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}
