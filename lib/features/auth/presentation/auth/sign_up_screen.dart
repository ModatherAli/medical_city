import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/navigation_routes.dart';
import '../../../../shared/validators/form_validators.dart';
import '../../../../shared/widgets/app_icon_widget.dart';
import '../../../../shared/widgets/beauty_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _hidePassword = true;

  // final bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();

  final TextEditingController _fullName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          // call the navigation on successful login to navigate to main screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(NavigationRoutes.redirect);
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
                  fieldName: 'Password',
                  controller: _password,
                  obscureText: _hidePassword,
                  validator: passwordValidatorFactory(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _hidePassword = !_hidePassword;
                      setState(() {});
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
                      _hidePassword = !_hidePassword;
                      setState(() {});
                    },
                    icon: Icon(
                      _hidePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: FilledButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            _onSignUp(context);
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

                // Or divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Or sign up with'.tr,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSignUp(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AuthBloc>().add(
      AuthSignUpRequested(_email.text.trim(), _password.text, _fullName.text),
    );
  }
}
