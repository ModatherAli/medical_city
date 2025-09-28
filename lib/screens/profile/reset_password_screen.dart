import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/auth_controller.dart';
import 'package:medical_city/screens/widgets/beauty_text_field.dart';
import 'package:medical_city/shared/validators/form_validators.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            BeautyTextField(
              fieldName: 'Email',
              controller: _email,
              validator: emailValidator,
              textDirection: TextDirection.ltr,
              textInputType: TextInputType.emailAddress,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Obx(
                () => _authController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : OutlinedButton(
                        onPressed: () => _onRestPassword(context),
                        child: Text('Password reset request'.tr),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRestPassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await _authController.resetPassword(_email.text.trim());
    // Show a confirmation message to the user
    Get.snackbar(
      'Password Reset',
      'A password reset link has been sent to your email.',
      snackPosition: SnackPosition.BOTTOM,
    );
    context.pushReplacement(NavigationRoutes.login);
  }
}
