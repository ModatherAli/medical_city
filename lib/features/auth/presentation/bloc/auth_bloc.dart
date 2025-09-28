import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/logger.dart';
import '../../domain/repo/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  // Store phone number for verification after signup
  // final String _pendingPhoneNumber = '';

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthResetPasswordRequested>(_onResetPasswordRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthRest>(_onAuthRest);
    on<AuthVerifyPhoneNumberRequested>(_onVerifyPhoneNumberRequested);
    on<AuthVerifyPhoneCodeRequested>(_onVerifyPhoneCodeRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.checkAuthStatus();

    result.fold((failure) => emit(AuthError(failure.message)), (authModel) {
      if (authModel != null) {
        emit(AuthAuthenticated(authModel));
      } else {
        emit(AuthLoggedOut());
      }
    });
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.signUpWithEmail(
      event.email,
      event.password,
      event.name,
    );
    Logger.print(result.toString());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authModel) => emit(AuthAuthenticated(authModel)),
    );
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.loginWithEmail(
      event.email,
      event.password,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authModel) => emit(AuthAuthenticated(authModel)),
    );
  }

  Future<void> _onResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.resetPassword(event.email);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthPasswordResetEmailSent()),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await authRepository.logout();

    emit(AuthLoggedOut());
  }

  Future<void> _onVerifyPhoneNumberRequested(
    AuthVerifyPhoneNumberRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.verifyPhoneNumber(event.phoneNumber);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (verificationId) =>
          emit(AuthPhoneCodeSent(verificationId, event.phoneNumber)),
    );
  }

  Future<void> _onVerifyPhoneCodeRequested(
    AuthVerifyPhoneCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.verifyPhoneCode(
      event.verificationId,
      event.smsCode,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authModel) => emit(AuthAuthenticated(authModel)),
    );
  }

  FutureOr<void> _onAuthRest(AuthRest event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
