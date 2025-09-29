import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_city/controllers/user_controller.dart';

class RedirectScreen extends StatelessWidget {
  final UserController authController = Get.find();

  RedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    });
  }
}
