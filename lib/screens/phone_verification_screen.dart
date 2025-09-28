import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/auth_controller.dart';
import 'package:medical_city/shared/widgets/beauty_text_field.dart';

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
  final AuthController _authController = Get.find();

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _authController.verificationId.value = widget.verificationId;
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
    return Obx(() {
      if (_authController.user != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(NavigationRoutes.main);
        });
      }

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
                'Please enter the 6-digit code sent to ${widget.phoneNumber}'.tr,
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
                child: _authController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : FilledButton(
                        onPressed: _onVerifyCode,
                        child: Text('Verify'.tr),
                      ),
              ),
              if (_authController.errorMessage.value.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  _authController.errorMessage.value,
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
    });
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
    await _authController.verifyPhoneCode(_codeController.text);
  }

  void _onResendCode() {
    setState(() {
      _countdown = 60;
    });
    _startCountdown();
    _authController.verifyPhoneNumber(widget.phoneNumber);
  }
}