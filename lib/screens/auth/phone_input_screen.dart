import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/user_controller.dart';
import 'package:medical_city/screens/widgets/app_icon_widget.dart';
import 'package:medical_city/screens/widgets/beauty_text_field.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            // SizedBox(height: 200),
            AppIconWidget(size: 200),
            Center(
              child: Text(
                'Enter your phone'.tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            BeautyTextField(
              fieldName: 'Phone Number',
              controller: _phoneController,
              textInputType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Phone is required'.tr;
                // Basic validation; expect E.164 input
                if (!v.trim().startsWith('+'))
                  return 'Use international format e.g. +966...'.tr;
                if (v.trim().length < 8) return 'Invalid phone number'.tr;
                return null;
              },
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: FilledButton(
                onPressed: _onStartVerification,
                child: Text('Continue'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onStartVerification() async {
    if (!_formKey.currentState!.validate()) return;
    final phone = _phoneController.text.trim();
    final controller = Get.find<UserController>();
    final verificationId = await controller.verifyPhoneNumber(phone);
    if (verificationId != null && mounted) {
      context.push(
        '${NavigationRoutes.phoneVerification}?phoneNumber=$phone&verificationId=$verificationId',
      );
    }
  }
}
