import 'package:elevare_ars/features/auth/presentation/widgets/authlayout.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/forgotpasswordform_widgets.dart';
import 'package:flutter/material.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLayout(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or Title
                  Text(
                    "Elevare Ars",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ForgotPasswordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
