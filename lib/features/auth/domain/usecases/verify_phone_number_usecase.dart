import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repo/auth_repo.dart';

class VerifyPhoneNumberUseCase
    implements UseCase<String, VerifyPhoneNumberParams> {
  final AuthRepository authRepository;

  VerifyPhoneNumberUseCase(this.authRepository);

  @override
  Future<Either<Failure, String>> call(VerifyPhoneNumberParams params) async {
    return await authRepository.verifyPhoneNumber(params.phoneNumber);
  }
}

class VerifyPhoneNumberParams {
  final String phoneNumber;

  VerifyPhoneNumberParams({required this.phoneNumber});
}
