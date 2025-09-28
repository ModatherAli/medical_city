import 'package:go_router/go_router.dart';
import 'package:medical_city/screens/auth/intro_screen.dart';
import 'package:medical_city/screens/auth/login_screen.dart';
import 'package:medical_city/screens/auth/phone_verification_screen.dart';
import 'package:medical_city/screens/auth/signup_screen.dart';
import 'package:medical_city/screens/main/main_screen.dart';
import 'package:medical_city/screens/main/redirect_screen.dart';
import 'package:medical_city/screens/profile/profile_screen.dart';
import 'package:medical_city/screens/profile/reset_password_screen.dart';
import 'package:medical_city/screens/profile/settings_screen.dart';

import 'navigation_routes.dart';

final appRouter = GoRouter(
  initialLocation: NavigationRoutes.redirect,
  routes: [
    GoRoute(
      path: NavigationRoutes.redirect,
      builder: (context, state) => RedirectScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.intro,
      builder: (context, state) => IntroScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.signup,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.login,
      builder: (context, state) => const LogInScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.restPassword,
      builder: (context, state) => ResetPasswordScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.phoneVerification,
      builder: (context, state) {
        final phoneNumber = state.uri.queryParameters['phoneNumber'] ?? '';
        final verificationId =
            state.uri.queryParameters['verificationId'] ?? '';
        return PhoneVerificationScreen(
          phoneNumber: phoneNumber,
          verificationId: verificationId,
        );
      },
    ),
    GoRoute(
      path: NavigationRoutes.main,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
