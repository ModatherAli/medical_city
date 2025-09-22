import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../models/auth_model.dart';
import '../repo/auth_repo.dart';

class SignUpWithEmailUseCase
    implements UseCase<AuthModel, SignUpWithEmailParams> {
  final AuthRepository authRepository;

  SignUpWithEmailUseCase(this.authRepository);

  @override
  Future<Either<Failure, AuthModel>> call(SignUpWithEmailParams params) async {
    return await authRepository.signUpWithEmail(
      params.email,
      params.password,
      params.displayName,
    );
  }
}

class SignUpWithEmailParams {
  final String email;
  final String password;
  final String displayName;

  SignUpWithEmailParams({
    required this.email,
    required this.password,
    required this.displayName,
  });
}
