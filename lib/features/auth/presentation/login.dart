import 'package:elevare_ars/core/config/routes/app_route_constants.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/authlayout.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/loginform_widgets.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/socialbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLayout(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialAuthButton(
                        textColor:
                            Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.black,
                        icon: FontAwesomeIcons.apple,
                        text: "Continue with Apple",
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 12),
                      SocialAuthButton(
                        textColor: Colors.white,
                        icon: FontAwesomeIcons.google,
                        text: "Continue with Google",
                        backgroundColor: Colors.blue.shade600,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
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
                  // Login Form
                  const LoginForm(),

                  const SizedBox(height: 40),
                  // Register link
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).pushNamed(MyAppRouteConstant.signUpRouteName);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don’t have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
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
