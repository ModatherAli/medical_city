import 'package:dartz/dartz.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'network_info.dart';

import '../errors/failure.dart';

Future<Either<Failure, T>> safeAPiCall<T>(
  Future<T> Function() apiCall, {
  required bool showLoading,
}) async {
  NetworkInfo networkInfo = NetworkInfo();
  if (await networkInfo.isConnected) {
    try {
      if (showLoading) await EasyLoading.show(status: 'In Progress...'.tr);
      final response = await apiCall();
      if (showLoading) await EasyLoading.dismiss();
      return Right(response);
    } catch (error) {
      if (showLoading) {
        await EasyLoading.showError(
          error.toString(),
          dismissOnTap: true,
          duration: const Duration(seconds: 5),
        );
      }
      return Left(Failure(error.toString()));
    }
  } else {
    if (showLoading) {
      await EasyLoading.showError(
        'No Internet Connection'.tr,
        dismissOnTap: true,
        duration: const Duration(seconds: 5),
      );
    }
    return Left(Failure('No Internet Connection'));
  }
}
