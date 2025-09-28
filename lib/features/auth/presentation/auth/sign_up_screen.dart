import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/features/auth/presentation/auth/widgets/other_auth_icon_buttons.dart';

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

  final TextEditingController _phoneNumber = TextEditingController();

  final TextEditingController _date = TextEditingController();

  bool _isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Listen for state changes to trigger phone verification
        if (state is AuthAuthenticated && _isSigningUp) {
          // After successful signup, trigger phone verification
          _isSigningUp = false;
          if (_phoneNumber.text.isNotEmpty) {
            context.read<AuthBloc>().add(
              AuthVerifyPhoneNumberRequested(_phoneNumber.text.trim()),
            );
          } else {
            // If no phone number provided, navigate to main screen
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(NavigationRoutes.redirect);
            });
          }
        }

        if (state is AuthPhoneCodeSent) {
          // Navigate to phone verification screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.push(
              '${NavigationRoutes.phoneVerification}?phoneNumber=${state.phoneNumber}&verificationId=${state.verificationId}',
            );
          });
        }
      },
      builder: (context, state) {
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

                OtherAuthIconButtons(),
                const SizedBox(height: 50),
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

    _isSigningUp = true;
    // Sign up the user with email and password
    context.read<AuthBloc>().add(
      AuthSignUpRequested(_email.text.trim(), _password.text, _fullName.text),
    );
  }
}
