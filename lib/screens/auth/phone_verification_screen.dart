import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/user_controller.dart';
import 'package:pinput/pinput.dart';

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
  final UserController _authController = Get.find();

  @override
  void initState() {
    super.initState();
    _startCountdown();
    // _authController.verificationId.value = widget.verificationId;
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        if (mounted) {
          setState(() {
            _countdown--;
          });
        }
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
    return GetBuilder<UserController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text('Verify Phone Number'.tr)),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text(
                  'Verification Code'.tr,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Please enter the 6-digit code sent to \n+${widget.phoneNumber}'
                      .tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),

                  child: Pinput(
                    validator: _codeValidator,

                    controller: _codeController,
                    onCompleted: (String value) async {
                      _onVerifyCode();
                    },
                    length: 6,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: FilledButton(
                    onPressed: _onVerifyCode,
                    child: Text('Verify'.tr),
                  ),
                ),
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
    final ok = await _authController.verifyPhoneCode(_codeController.text);
    if (!mounted) return;
    if (ok) {
      context.go(NavigationRoutes.redirect);
    }
  }

  void _onResendCode() {
    _countdown = 60;
    setState(() {});
    _startCountdown();
    _authController.verifyPhoneNumber(widget.phoneNumber);
  }
}
