import 'package:elevare_ars/features/auth/presentation/forgotpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: Supabase login logic
      debugPrint("Email: ${_emailCtrl.text}, Password: ${_passwordCtrl.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
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
          const SizedBox(height: 16),

          // Password
          TextFormField(
            controller: _passwordCtrl,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: Color(0xFFF5F5F5),
            ),
            validator: (val) {
              if (val == null || val.isEmpty) return "Enter your password";
              if (val.length < 6) return "Password too short";
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Login Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onLogin,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                // Navigate to Forgot Password page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Forgotpassword(),
                  ),
                );
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
