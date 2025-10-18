import 'package:elevare_ars/core/widgets/form%20widgets/textfield.dart';
import 'package:elevare_ars/core/widgets/progress_loading.dart';
import 'package:elevare_ars/core/widgets/snackbar_widget.dart';
import 'package:elevare_ars/features/auth/provider/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({super.key});

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmpasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void onSignup() async {
    final String email = _emailCtrl.text.trim();
    final String password = _passwordCtrl.text.trim();
    final String lastname = _lastNameCtrl.text.trim();
    final String firstname = _firstNameCtrl.text.trim();

    try {
      if (_formKey.currentState!.validate()) {
        setState(() => _isLoading = true);
        final response = await ref.read(
          sigUpWithEmailProvider((
            email: email,
            password: password,
            firstname: firstname,
            lastname: lastname,
          )).future,
        );
        if (!mounted) return;

        if (response.error != null) {
          snackbarErrorMessage(response.error.toString());
        }
      }
    } catch (e) {
      snackbarErrorMessage(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _isLoading = false;
  bool _hiddenPassword = true;
  bool _hiddenConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              // First Name
              Expanded(
                child: TextFormField(
                  controller: _firstNameCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration_('First Name'),
                  validator: (val) =>
                      val == null || val.isEmpty ? "Enter first name" : null,
                ),
              ),
              const SizedBox(width: 8),

              // Last Name
              Expanded(
                child: TextFormField(
                  controller: _lastNameCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration_('Last Name'),
                  validator: (val) =>
                      val == null || val.isEmpty ? "Enter last name" : null,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),

          const SizedBox(height: 16),
          // Email
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
            decoration: inputDecoration_('Email'),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Enter your email";
              }
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
              if (val.length < 8) return "Password must be 8+ chars";
              return null;
            },
          ),
          const SizedBox(height: 16),
          //Confirm Password
          TextFormField(
            controller: _confirmpasswordCtrl,
            obscureText: _hiddenConfirmPassword,
            decoration: inputDecorationSuffix(
              'Confirm Password',
              IconButton(
                onPressed: () => setState(
                  () => _hiddenConfirmPassword = !_hiddenConfirmPassword,
                ),
                icon: Icon(
                  _hiddenPassword ? Icons.visibility_off : Icons.visibility,
                  size: 16,
                ),
              ),
            ),
            validator: (val) {
              if (val == null || val.isEmpty) return "Confirm your password";
              if (val != _passwordCtrl.text) return "Password do not match";
              return null;
            },
          ),

          const SizedBox(height: 20),
          // Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : onSignup,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? ProgressLoading(color: Colors.white, size: 20)
                  : const Text("Sign Up"),
            ),
          ),
        ],
      ),
    );
  }
}
