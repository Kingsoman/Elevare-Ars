import 'package:elevare_ars/features/auth/presentation/login.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/inputdecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _onSendReset() {
    if (_formKey.currentState!.validate()) {
      // TODO: hook into Supabase password reset
      debugPrint("Send reset link to: ${_emailCtrl.text}");
    }
  }

  void _goBackToLogin() {
    // instead of using route name, point to LoginForm widget directly
    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          const Text(
            "Forgot Password?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Enter your email and we’ll send you reset instructions.",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 24),

          // Email field
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
            decoration: inputDecoration_("Email"),
            validator: (val) {
              if (val == null || val.isEmpty) return "Enter your email";
              if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(val)) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Reset button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onSendReset,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Send Reset Link"),
            ),
          ),
          const SizedBox(height: 20),

          // Back to login
          GestureDetector(
            onTap: _goBackToLogin,
            child: Text.rich(
              TextSpan(
                text: "Remembered your password? ",
                style: TextStyle(fontSize: 12),
                children: [
                  TextSpan(
                    text: "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
