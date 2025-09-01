import 'package:elevare_ars/features/auth/presentation/signup.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/authlayout.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/loginform_widgets.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/socialbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthLayout(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(24.0),
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

                  // Login Form
                  const LoginForm(),

                  const SizedBox(height: 30),

                  // Divider
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "or continue with",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialAuthButton(
                        icon: FontAwesomeIcons
                            .google, // Google icon from FontAwesome
                        color: Colors.red,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 12),
                      SocialAuthButton(
                        icon: FontAwesomeIcons.facebook,
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Register link
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don’t have an account? ",
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
