import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:medical_city/controllers/auth_controller.dart';

import '../../firebase_options.dart';

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

  // Initialize AuthController
  Get.put(AuthController());
}