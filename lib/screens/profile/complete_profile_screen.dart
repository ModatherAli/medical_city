import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/user_controller.dart';
import 'package:medical_city/models/user_model.dart';
import 'package:medical_city/screens/widgets/beauty_text_field.dart';
import 'package:medical_city/shared/validators/form_validators.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String phoneNumber;
  const CompleteProfileScreen({super.key, required this.phoneNumber});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete your profile'.tr)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const SizedBox(height: 24),
            BeautyTextField(
              fieldName: 'Full name',
              controller: _name,
              validator: minLengthValidator(3),
            ),
            BeautyTextField(
              fieldName: 'Email',
              controller: _email,
              validator: emailValidator,
              textInputType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: FilledButton(onPressed: _onSave, child: Text('Save'.tr)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;
    final controller = Get.find<UserController>();
    final user = UserModel(
      id: '',
      name: _name.text.trim(),
      email: _email.text.trim(),
      phone: widget.phoneNumber,
      imageUrl: '',
      joinAt: DateTime.now(),
      birthDate: DateTime.now(),
    );
    final saved = await controller.saveCompletedProfile(user);
    if (!mounted) return;
    if (saved) {
      context.go(NavigationRoutes.main);
    }
  }
}
