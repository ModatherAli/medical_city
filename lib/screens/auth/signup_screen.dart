import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/auth_controller.dart';
import 'package:medical_city/screens/widgets/app_icon_widget.dart';
import 'package:medical_city/screens/widgets/beauty_text_field.dart';
import 'package:medical_city/screens/widgets/other_auth_icon_buttons.dart';
import 'package:medical_city/shared/validators/form_validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _hidePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_authController.currentUser != null && _phoneNumber.text.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(NavigationRoutes.main);
        });
      }
      if (_authController.verificationId.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.push(
            '${NavigationRoutes.phoneVerification}?phoneNumber=${_phoneNumber.text.trim()}&verificationId=${_authController.verificationId.value}',
          );
          _authController.verificationId.value = ''; // Reset after navigation
        });
      }

      return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const Center(child: AppIconWidget()),
              Center(
                child: Text(
                  'Sign Up'.tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 15),
              BeautyTextField(
                fieldName: 'Your name',
                controller: _fullName,
                validator: minLengthValidator(4),
              ),
              BeautyTextField(
                fieldName: 'Email',
                controller: _email,
                validator: emailValidator,
                textDirection: TextDirection.ltr,
                textInputType: TextInputType.emailAddress,
              ),
              BeautyTextField(
                fieldName: 'Phone Number',
                controller: _phoneNumber,
                validator: phoneNumberValidator,
                textDirection: TextDirection.ltr,
                textInputType: TextInputType.phone,
              ),
              BeautyTextField(
                fieldName: 'Password',
                controller: _password,
                obscureText: _hidePassword,
                validator: passwordValidatorFactory(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  icon: Icon(
                    _hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              BeautyTextField(
                fieldName: 'Confirm password',
                controller: _confirmPassword,
                obscureText: _hidePassword,
                validator: confirmPasswordValidator(() => _password.text),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  icon: Icon(
                    _hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _date.text = "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                child: BeautyTextField(
                  fieldName: 'Date of birth',
                  enabled: false,
                  controller: _date,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: _authController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : FilledButton(
                        onPressed: _onSignUp,
                        child: Text('Sign Up'.tr),
                      ),
              ),
              if (_authController.errorMessage.value.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _authController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have an account?'.tr),
                  TextButton(
                    onPressed: () {
                      context.pushReplacement(NavigationRoutes.login);
                    },
                    child: Text('Log In'.tr),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              OtherAuthIconButtons(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );
    });
  }

  void _onSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await _authController.signUpWithEmail(
      _email.text.trim(),
      _password.text,
      _fullName.text.trim(),
    );
    if (_authController.currentUser != null && _phoneNumber.text.isNotEmpty) {
      await _authController.verifyPhoneNumber(_phoneNumber.text.trim());
    }
  }
}
