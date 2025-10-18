import 'package:elevare_ars/core/config/responsive%20layout/check_platform_device.dart';
import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/authlayout.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/signupform_widgets.dart';
import 'package:elevare_ars/features/auth/presentation/widgets/socialbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLayout(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PlatformHelper.isIOS ||
                              PlatformHelper.isMacOS ||
                              PlatformHelper.isAppleBrowser
                          ? SocialAuthButton(
                              textColor:
                                  Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                              icon: FontAwesomeIcons.apple,
                              text: "Continue with Apple",
                              backgroundColor:
                                  Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                              onPressed: () {},
                            )
                          : SizedBox.shrink(),
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

                  //TextFields/////////
                  SignupForm(),

                  const SizedBox(height: 24),

                  // Already have an account
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        context.pushReplacementNamed(
                          MyAppRouteConstant.loginRouteName,
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          children: [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
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
