import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../models/auth_model.dart';
import '../repo/auth_repo.dart';

class VerifyPhoneCodeUseCase
    implements UseCase<AuthModel, VerifyPhoneCodeParams> {
  final AuthRepository authRepository;

  VerifyPhoneCodeUseCase(this.authRepository);

  @override
  Future<Either<Failure, AuthModel>> call(VerifyPhoneCodeParams params) async {
    return await authRepository.verifyPhoneCode(
      params.verificationId,
      params.smsCode,
    );
  }
}

class VerifyPhoneCodeParams {
  final String verificationId;
  final String smsCode;

  VerifyPhoneCodeParams({required this.verificationId, required this.smsCode});
}
