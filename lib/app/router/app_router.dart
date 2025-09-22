import 'package:go_router/go_router.dart';
import 'package:medical_city/features/auth/presentation/auth/auth.dart';
import 'package:medical_city/features/auth/presentation/intro/intro_screen.dart';

import '../../features/redirect/redirect_screen.dart';
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
      builder: (context, state) => SignUpScreen(),
    ),

    GoRoute(
      path: NavigationRoutes.login,
      builder: (context, state) => LogInScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.restPassword,
      builder: (context, state) => ResetPasswordScreen(),
    ),
    // GoRoute(
    //   path: '/phone-auth',
    //   builder: (context, state) => const PhoneAuthScreen(),
    // ),
    // GoRoute(
    //   path: NavigationRoutes.main,
    //   builder: (context, state) => MainScreen(),
    // ),
    // GoRoute(
    //   path: NavigationRoutes.subscription,
    //   builder: (context, state) => SubscriptionScreen(),
    // ),
    // GoRoute(
    //   path: NavigationRoutes.editAccount,
    //   builder: (context, state) => EditAccountScreen(),
    // ),
    // GoRoute(
    //   path: NavigationRoutes.addStock,
    //   builder: (context, state) => const AddUpdateStockScreen(),
    // ),
    // GoRoute(
    //   path: NavigationRoutes.editStock,
    //   builder: (context, state) {
    //     final stock = state.extra as Stock?;
    //     return AddUpdateStockScreen(stock: stock);
    //   },
    // ),
    // GoRoute(
    //   path: NavigationRoutes.options,
    //   builder: (context, state) => const OptionsScreen(),
    // ),
    // GoRoute(
    //   path: NavigationRoutes.addOption,
    //   builder: (context, state) => const AddUpdateOptionScreen(),
    // ),
    // GoRoute(
    //   path: NavigationRoutes.editOption,
    //   builder: (context, state) {
    //     final option = state.extra as OptionRecommendation?;
    //     return AddUpdateOptionScreen(option: option);
    //   },
    // ),
    // GoRoute(
    //   path: NavigationRoutes.archive,
    //   builder: (context, state) => const ArchiveScreen(),
    // ),
    // GoRoute(
    //   path: NavigationRoutes.chat,
    //   builder: (context, state) => const ChatScreen(),
    // ),
    // GoRoute(
    //   path: '/chat/:conversationId',
    //   builder: (context, state) {
    //     final conversationId = state.pathParameters['conversationId'];
    //     return ChatScreen(conversationId: conversationId);
    //   },
    // ),
    // GoRoute(
    //   path: NavigationRoutes.conversations,
    //   builder: (context, state) => const ConversationsScreen(),
    // ),
    // GoRoute(
    //   path: NavigationRoutes.notifications,
    //   builder: (context, state) => const NotificationsScreen(),
    // ),
  ],
);
