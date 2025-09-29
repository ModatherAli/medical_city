import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/user_controller.dart';
import 'package:medical_city/screens/widgets/app_icon_widget.dart';
import 'package:medical_city/screens/widgets/beauty_text_field.dart';
import 'package:medical_city/screens/widgets/other_auth_icon_buttons.dart';
import 'package:medical_city/shared/validators/form_validators.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

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
                    'Log In'.tr,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 15),
                BeautyTextField(
                  fieldName: 'Email',
                  controller: _email,
                  validator: emailValidator,
                  textDirection: TextDirection.ltr,
                  textInputType: TextInputType.emailAddress,
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
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: OutlinedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      await authController.signInWithEmail(
                        _email.text.trim(),
                        _password.text,
                      );
                    },
                    child: Text('Log In'.tr),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('New here?'.tr),
                    TextButton(
                      onPressed: () {
                        context.pushReplacement(NavigationRoutes.signup);
                      },
                      child: Text('Open account'.tr),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    context.push(NavigationRoutes.restPassword);
                  },
                  child: Text('Forgot your password?'.tr),
                ),
                const SizedBox(height: 20),
                OtherAuthIconButtons(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
