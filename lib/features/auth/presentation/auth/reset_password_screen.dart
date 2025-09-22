import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/navigation_routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../shared/validators/form_validators.dart';
import '../../../../shared/widgets/beauty_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthPasswordResetEmailSent) {
          // call the navigation on successful login to navigate to main screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.pushReplacement(NavigationRoutes.login);
          });
        }

        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
                BeautyTextField(
                  fieldName: 'Email',
                  controller: _email,
                  validator: emailValidator,
                  textDirection: TextDirection.ltr,
                  textInputType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  child: OutlinedButton(
                    onPressed: () => _onRestPassword(context),
                    child: Text('Password reset request'.tr),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onRestPassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AuthBloc>().add(
      AuthResetPasswordRequested(_email.text.trim()),
    );
  }
}
