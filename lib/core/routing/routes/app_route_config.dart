import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/features/auth/domain/gorouter_refresh_stream.dart';
import 'package:elevare_ars/features/auth/presentation/forgotpassword.dart';
import 'package:elevare_ars/features/auth/presentation/login.dart';
import 'package:elevare_ars/features/auth/presentation/signup.dart';
import 'package:elevare_ars/features/auth/provider/auth_provider.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/get_started_screen.dart';
import 'package:elevare_ars/features/mentorship/presentation/screens/mentorship_request_form_page.dart';
import 'package:elevare_ars/features/mentorship/presentation/screens/mentorshipwrapper.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:elevare_ars/features/profile/presentation/screens/profile_screen.dart';
import 'package:elevare_ars/screens/feeds/feeds.dart';
import 'package:elevare_ars/screens/homepage/presentation/anonymous_login/home.dart';
import 'package:elevare_ars/features/mentorship/presentation/screens/mentorship_request_screen.dart';
import 'package:elevare_ars/screens/onboarding%20screen/presentation/onboarding_screen.dart';
import 'package:elevare_ars/screens/onboarding%20screen/provider/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Define your auth routes
final authRoutes = ['/login', '/signup', '/forgotpassword'];

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(
      Supabase.instance.client.auth.onAuthStateChange,
    ),
    // The GoRouter redirect function:
    redirect: (context, state) {
      final container = ProviderScope.containerOf(context);
      final location = state.matchedLocation;

      // 1. Onboarding Check (Keep this separate and first)
      final showOnboarding = container
          .read(onboardingProvider)
          .when(
            data: (value) => value,
            loading: () => false,
            error: (_, __) => false,
          );
      if (showOnboarding && location != "/onboarding") {
        return "/onboarding";
      }

      // --- AUTH AND CLEANUP ---
      final session = container.read(authServiceProvider).currentSession;
      final isLoggedIn = session != null;
      final isGoingToAuthRoute = authRoutes.contains(location);
      final userMetaData = session?.user.userMetadata;

      // Check for 'code' in query/fragment to detect polluted OAuth URL
      final isUrlPolluted =
          state.uri.queryParameters.containsKey('code') ||
          (state.uri.hasFragment && state.uri.fragment.contains('code='));

      // 2. Logged-Out Access Check
      if (!isLoggedIn && !isGoingToAuthRoute) {
        // Not logged in and trying to access a protected page
        return "/login";
      }

      // 3. chekck if user is loggedin and has completed the getstarted page
      if (isLoggedIn && userMetaData?['hasSeenGetStartedPage'] == false) {
        return '/getstarted';
      }

      // 3. Logged-In Redirects (Cleanup and Auth Page Block)
      // The two conditions are: URL cleanup is needed OR user is trying to access a login/signup route.
      if (isLoggedIn) {
        if (isUrlPolluted || isGoingToAuthRoute) {
          // This only runs when necessary.
          return "/feeds";
        }
      }
      // If not redirected, the function proceeds to return null, allowing normal navigation.

      return null;
    },
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
        pageBuilder: (context, state) => MaterialPage(child: Feeds()),
      ),
      // GoRoute(
      //   name: MyAppRouteConstant.mentorDashboardMentorRouteName,
      //   path: "/dashboard",
      //   pageBuilder: (context, state) => MaterialPage(child: MentorDashboard()),
      // ),

      // GoRoute(
      //   name: MyAppRouteConstant.studentDashboardMentorRouteName,
      //   path: "/notifications",
      //   pageBuilder: (context, state) =>
      //       MaterialPage(child: StudentDashboard()),
      // ),
      GoRoute(
        name: MyAppRouteConstant.onboardingRouteName,
        path: '/onboarding',
        pageBuilder: (context, state) =>
            MaterialPage(child: OnboardingScreen()),
      ),

      GoRoute(
        name: MyAppRouteConstant.forgotPasswordRouteName,
        path: "/forgotpassword",
        pageBuilder: (context, state) => MaterialPage(child: Forgotpassword()),
      ),

      GoRoute(
        name: MyAppRouteConstant.mentorshipRequestsRouteName,
        path: "/mentorshipRequests",
        pageBuilder: (context, state) =>
            MaterialPage(child: MentorRequestsPage()),
      ),
      GoRoute(
        name: MyAppRouteConstant.welcomeOnboardingRouteName,
        path: "/getstarted",
        pageBuilder: (context, state) =>
            MaterialPage(child: GetStartedScreen()),
      ),

      GoRoute(
        path: '/profile/:userId',
        name: MyAppRouteConstant.profileRouteName,
        pageBuilder: (context, state) {
          final userId = state.pathParameters['userId'];
          return MaterialPage(child: ProfileScreen(userId: userId));
        },
      ),
      GoRoute(
        name: MyAppRouteConstant.myProfileRouteName,
        path: '/profile', // 👈 Now this path works
        pageBuilder: (context, state) {
          // userId is intentionally null, letting ProfileScreen use currentUserProfileProvider
          return const MaterialPage(child: ProfileScreen(userId: null));
        },
      ),
      GoRoute(
        path: '/mentorshipRequestForm/:userId',
        name: MyAppRouteConstant.mentorshipRequestFormRouteName,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final userId = state.pathParameters['userId'];

          //  If full MentorProfile passed via extra
          if (extra is MentorProfile) {
            return MaterialPage(child: MentorshipRequestForm(mentor: extra));
          }

          //  If only userId is provided, fetch profile first
          if (userId != null) {
            return MaterialPage(
              child: MentorshipRequestWrapper(userId: userId),
            );
          }

          // If neither is passed
          return const MaterialPage(
            child: Scaffold(
              body: Center(child: Text('Invalid mentorship request route')),
            ),
          );
        },
      ),
    ],
  );
});
