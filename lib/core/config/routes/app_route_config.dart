import 'package:elevare_ars/core/config/routes/app_route_constants.dart';
import 'package:elevare_ars/features/auth/presentation/forgotpassword.dart';
import 'package:elevare_ars/features/auth/presentation/login.dart';
import 'package:elevare_ars/features/auth/presentation/signup.dart';
import 'package:elevare_ars/screens/dahsboard/mentor/mentor_dashboard.dart';
import 'package:elevare_ars/screens/dahsboard/student/student_dashboard.dart';
import 'package:elevare_ars/screens/feeds/feeds.dart';
import 'package:elevare_ars/screens/homepage/presentation/anonymous_login/home.dart';
import 'package:elevare_ars/screens/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAppRoutes {
  GoRouter appRouter = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRouteConstant.feedsRouteName,
        path: "/feeds",
        pageBuilder: (context, state) => MaterialPage(child: Feeds()),
      ),

      GoRoute(
        name: MyAppRouteConstant.loginRouteName,
        path: "/login",
        pageBuilder: (context, state) => MaterialPage(child: LoginPage()),
      ),

      GoRoute(
        name: MyAppRouteConstant.signUpRouteName,
        path: "/signup",
        pageBuilder: (context, state) => MaterialPage(child: SignUpPage()),
      ),

      GoRoute(
        name: MyAppRouteConstant.homeRouteName,
        path: "/home",
        pageBuilder: (context, state) => MaterialPage(child: Homepage()),
      ),

      GoRoute(
        name: MyAppRouteConstant.rootRouteName,
        path: "/",
        pageBuilder: (context, state) => MaterialPage(child: LoginPage()),
      ),

      GoRoute(
        name: MyAppRouteConstant.mentorDashboardMentorRouteName,
        path: "/dashboard",
        pageBuilder: (context, state) => MaterialPage(child: MentorDashboard()),
      ),

      GoRoute(
        name: MyAppRouteConstant.studentDashboardMentorRouteName,
        path: "/notifications",
        pageBuilder: (context, state) =>
            MaterialPage(child: StudentDashboard()),
      ),
      GoRoute(
        name: MyAppRouteConstant.onboardingRouteName,
        path: '/onboarding',
        pageBuilder: (context, state) =>
            MaterialPage(child: OnboardingScreen()),
      ),

      GoRoute(
        name: MyAppRouteConstant.forgotPasswordRouteName,
        path: "/forgotpaswword",
        pageBuilder: (context, state) => MaterialPage(child: Forgotpassword()),
      ),
    ],
  );
}
