import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/navigation_routes.dart';
import '../../../../shared/widgets/beauty_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const PhoneVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  int _countdown = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // After successful phone verification, navigate to main screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(NavigationRoutes.main);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Verify Phone Number'.tr)),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                Text(
                  'Verification Code'.tr,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Please enter the 6-digit code sent to ${widget.phoneNumber}'
                      .tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                BeautyTextField(
                  fieldName: 'Verification Code',
                  controller: _codeController,
                  validator: _codeValidator,
                  textInputType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: FilledButton(
                    onPressed: state is AuthLoading ? null : _onVerifyCode,
                    child: Text('Verify'.tr),
                  ),
                ),
                if (state is AuthError) ...[
                  const SizedBox(height: 20),
                  Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _countdown > 0 ? null : _onResendCode,
                  child: _countdown > 0
                      ? Text('Resend Code in $_countdown seconds'.tr)
                      : Text('Resend Code'.tr),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _codeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the verification code'.tr;
    }
    if (value.length != 6) {
      return 'Code must be 6 digits'.tr;
    }
    return null;
  }

  void _onVerifyCode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AuthBloc>().add(
      AuthVerifyPhoneCodeRequested(widget.verificationId, _codeController.text),
    );
  }

  void _onResendCode() {
    _countdown = 60;
    _startCountdown();
    context.read<AuthBloc>().add(
      AuthVerifyPhoneNumberRequested(widget.phoneNumber),
    );
  }
}
