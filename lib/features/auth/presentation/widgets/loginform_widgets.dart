import 'package:elevare_ars/core/config/routes/app_route_constants.dart';
import 'package:elevare_ars/features/auth/presentation/forgotpassword.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/inputdecoration.dart';
import 'package:elevare_ars/screens/feeds/feeds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

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
      GoRouter.of(
        context,
      ).pushReplacementNamed(MyAppRouteConstant.feedsRouteName);
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
            decoration: inputDecoration_('Email'),
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
            decoration: inputDecoration_('Password'),
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Login"),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,

            child: GestureDetector(
              onTap: () {
                // Navigate to Forgot Password page
                GoRouter.of(
                  context,
                ).pushNamed(MyAppRouteConstant.forgotPasswordRouteName);
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
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
