import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/auth_controller.dart';

class RedirectScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  RedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (authController.user != null) {
            context.go(NavigationRoutes.main);
          } else {
            context.go(NavigationRoutes.login);
          }
        });
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
    });
  }
}