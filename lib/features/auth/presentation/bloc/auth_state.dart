import 'package:equatable/equatable.dart';

import '../../domain/models/auth_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthModel authModel;

  const AuthAuthenticated(this.authModel);

  @override
  List<Object?> get props => [authModel];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoggedOut extends AuthState {}

class AuthPasswordResetEmailSent extends AuthState {}

class AuthPhoneCodeSent extends AuthState {
  final String verificationId;
  final String phoneNumber;

  const AuthPhoneCodeSent(this.verificationId, this.phoneNumber);

  @override
  List<Object?> get props => [verificationId, phoneNumber];
}
