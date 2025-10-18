import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/core/widgets/form%20widgets/textfield.dart';
import 'package:elevare_ars/core/widgets/progress_loading.dart';
import 'package:elevare_ars/core/widgets/snackbar_widget.dart';
import 'package:elevare_ars/features/auth/provider/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  bool _isLoading = false; //bool for loading indicator

  void _onLogin() async {
    final String email = _emailCtrl.text.trim();
    final String password = _passwordCtrl.text.trim();

    try {
      if (_formKey.currentState!.validate()) {
        setState(() => _isLoading = true);
        final response = await ref.read(
          loginWithEmailProvider((email: email, password: password)).future,
        );
        if (!mounted) return;
        if (response.error != null) {
          debugPrint("Signed in");
          snackbarErrorMessage(response.error.toString());
        }
      }
    } catch (e) {
      snackbarErrorMessage(e.toString());
    } finally {
      if (mounted) {
        ref.invalidate(loginWithEmailProvider);
        setState(() => _isLoading = false);
      }
    }
  }

  bool _hiddenPassword = true;
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
              if (!EmailValidator.validate(val)) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password
          TextFormField(
            controller: _passwordCtrl,
            obscureText: _hiddenPassword,

            decoration: inputDecorationSuffix(
              'Password',
              IconButton(
                onPressed: () =>
                    setState(() => _hiddenPassword = !_hiddenPassword),
                icon: Icon(
                  _hiddenPassword ? Icons.visibility_off : Icons.visibility,
                  size: 16,
                ),
              ),
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
              onPressed: _isLoading ? null : _onLogin,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? ProgressLoading(size: 20, color: Colors.white)
                  : const Text("Login"),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,

            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => context.goNamed(
                  MyAppRouteConstant.forgotPasswordRouteName,
                ), // Navigate to Forgot Password page
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
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
