import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/user_controller.dart';
import 'package:medical_city/screens/auth/intro_screen.dart';
import 'package:medical_city/screens/main/bottom_nav_bar.dart';
import 'package:medical_city/screens/widgets/loading_view.dart';

class RedirectScreen extends StatelessWidget {
  const RedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const IntroScreen();
    } else {
      return GetBuilder<UserController>(
        builder: (authController) {
          if (authController.currentUser.id.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              authController.getUserData();
            });
            return LoadingView();
          }
          if (authController.currentUser.name.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(NavigationRoutes.completeProfile);
            });
          }
          return const BottomNavBar();
        },
      );
    }
  }
}
