import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _onSignup() {
    if (_formKey.currentState!.validate()) {
      debugPrint(
        "First: ${_firstNameCtrl.text}, Last: ${_lastNameCtrl.text}, "
        "Email: ${_emailCtrl.text}, Password: ${_passwordCtrl.text}",
      );
      // TODO: Supabase signup logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // First Name
          TextFormField(
            controller: _firstNameCtrl,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: "First Name",
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: Color(0xFFF5F5F5),
            ),
            validator: (val) =>
                val == null || val.isEmpty ? "Enter first name" : null,
          ),
          const SizedBox(height: 16),

          // Last Name
          TextFormField(
            controller: _lastNameCtrl,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: "Last Name",
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: Color(0xFFF5F5F5),
            ),
            validator: (val) =>
                val == null || val.isEmpty ? "Enter last name" : null,
          ),
          const SizedBox(height: 16),

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
              if (val.length < 6) return "Password must be 6+ chars";
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onSignup,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
