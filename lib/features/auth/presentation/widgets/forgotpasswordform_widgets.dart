import 'package:elevare_ars/features/auth/presentation/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
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
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 24),

          // Email field
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: Color(0xFFF5F5F5),
            ),
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
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Send Reset Link",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Back to login
          GestureDetector(
            onTap: _goBackToLogin,
            child: Text.rich(
              TextSpan(
                text: "Remembered your password? ",
                style: const TextStyle(color: Colors.black54),
                children: [
                  TextSpan(
                    text: "Login",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
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
