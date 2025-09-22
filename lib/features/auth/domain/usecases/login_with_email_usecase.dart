import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../models/auth_model.dart';
import '../repo/auth_repo.dart';

class LoginWithEmailUseCase
    implements UseCase<AuthModel, LoginWithEmailParams> {
  final AuthRepository authRepository;

  LoginWithEmailUseCase(this.authRepository);

  @override
  Future<Either<Failure, AuthModel>> call(LoginWithEmailParams params) async {
    return await authRepository.loginWithEmail(params.email, params.password);
  }
}

class LoginWithEmailParams {
  final String email;
  final String password;

  LoginWithEmailParams({required this.email, required this.password});
}
