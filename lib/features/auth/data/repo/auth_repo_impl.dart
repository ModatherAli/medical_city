import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/models/auth_model.dart';
import '../../domain/repo/auth_repo.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, AuthModel>> loginWithEmail(
    String email,
    String password,
  ) async {
    final result = await authRemoteDatasource.signInWithEmail(
      email: email,
      password: password,
    );

    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, AuthModel>> signUpWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    final result = await authRemoteDatasource.signUpWithEmail(
      email: email,
      password: password,
      name: displayName,
    );

    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, bool>> resetPassword(String email) async {
    final result = await authRemoteDatasource.resetPassword(email: email);

    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, AuthModel?>> checkAuthStatus() async {
    final result = await authRemoteDatasource.checkAuthStatus();
    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final result = await authRemoteDatasource.logout();
    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }
}
