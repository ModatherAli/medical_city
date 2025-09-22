import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/auth_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel?>> checkAuthStatus();

  Future<Either<Failure, AuthModel>> signUpWithEmail(
    String email,
    String password,
    String displayName,
  );

  Future<Either<Failure, AuthModel>> loginWithEmail(
    String email,
    String password,
  );

  Future<Either<Failure, bool>> resetPassword(String email);
  Future<Either<Failure, void>> logout();
}
