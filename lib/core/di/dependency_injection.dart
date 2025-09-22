import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_city/features/auth/data/repo/auth_repo_impl.dart';
import 'package:medical_city/features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../firebase_options.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 5)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..maskType = EasyLoadingMaskType.black
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorColor = Colors.green
    ..errorWidget = const Icon(Icons.error_outline, color: Colors.red, size: 40)
    ..dismissOnTap = false;

  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Auth dependencies
  getIt.registerSingleton<AuthRemoteDatasource>(AuthRemoteDatasource());
  getIt.registerSingleton<AuthRepositoryImpl>(
    AuthRepositoryImpl(authRemoteDatasource: getIt<AuthRemoteDatasource>()),
  );
  getIt.registerSingleton<AuthBloc>(
    AuthBloc(authRepository: getIt<AuthRepositoryImpl>()),
  );

  // // User dependencies
  // getIt.registerSingleton<UserRemoteDatasource>(UserRemoteDatasource());
  // getIt.registerSingleton<UserRepositoryImpl>(
  //   UserRepositoryImpl(userRemoteDatasource: getIt<UserRemoteDatasource>()),
  // );
  // getIt.registerSingleton<UserBloc>(UserBloc(getIt<UserRepositoryImpl>()));

  // // Stock dependencies
  // getIt.registerSingleton<StockRemoteDatasource>(StockRemoteDatasource());
  // getIt.registerSingleton<StockRepoImpl>(
  //   StockRepoImpl(getIt<StockRemoteDatasource>()),
  // );
  // getIt.registerSingleton<StockBloc>(StockBloc(getIt<StockRepoImpl>()));

  // // Options dependencies
  // getIt.registerSingleton<OptionRemoteDatasource>(OptionRemoteDatasource());
  // getIt.registerSingleton<OptionRepoImpl>(
  //   OptionRepoImpl(getIt<OptionRemoteDatasource>()),
  // );
  // getIt.registerSingleton<OptionBloc>(OptionBloc(getIt<OptionRepoImpl>()));

  // // Archive dependencies
  // getIt.registerSingleton<ArchiveRemoteDatasource>(ArchiveRemoteDatasource());
  // getIt.registerSingleton<ArchiveRepoImpl>(
  //   ArchiveRepoImpl(getIt<ArchiveRemoteDatasource>()),
  // );
  // getIt.registerSingleton<ArchiveBloc>(ArchiveBloc(getIt<ArchiveRepoImpl>()));

  // // Notification dependencies
  // getIt.registerSingleton<NotificationService>(NotificationService());

  // // Subscription dependencies
  // getIt.registerSingleton<PaymentService>(PaymentService());
  // getIt.registerSingleton<SubscriptionBloc>(
  //   SubscriptionBloc(getIt<PaymentService>()),
  // );

  // // Initialize FCM token management after DI setup
  // WidgetsBinding.instance.addPostFrameCallback((_) async {
  //   try {
  //     await getIt<NotificationService>().initializeFCMTokenManagement();
  //   } catch (e) {
  //     print('Error initializing FCM token management: $e');
  //   }
  // });
}
