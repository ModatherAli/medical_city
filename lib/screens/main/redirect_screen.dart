import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_city/controllers/user_controller.dart';
import 'package:medical_city/screens/auth/intro_screen.dart';
import 'package:medical_city/screens/main/bottom_nav_bar.dart';

class RedirectScreen extends StatelessWidget {
  final UserController _authController = Get.find();

  RedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const IntroScreen();
    } else {
      _authController.getUserData();
      return const BottomNavBar();
    }
  }
}
