import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/user_controller.dart';
import 'package:medical_city/models/user_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (authController) {
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
                  child: FilledButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      UserModel userModel = UserModel(
                        id: '',
                        email: _email.text.trim(),
                        name: _fullName.text.trim(),
                        phone: _phoneNumber.text.trim(),
                        imageUrl: '',
                        joinAt: DateTime.now(),
                        birthDate: DateTime.parse(_date.text),
                      );

                      await authController.signUpWithEmail(
                        _email.text.trim(),
                        _password.text,
                        userModel,
                      );
                    },
                    child: Text('Sign Up'.tr),
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
      },
    );
  }
}
