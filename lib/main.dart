import 'package:flutter/material.dart';

import 'app/stox_app.dart';
import 'core/di/dependency_injection.dart';
import 'core/services/language_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await LanguageService.initializeLanguage();
  runApp(const MedicalCityApp());
}
