import 'package:flutter/material.dart';

import 'app/medical_city_app.dart';
import 'core/di/dependency_injection.dart';
import 'services/language_service.dart';

void main() async {
  await configureDependencies();
  await LanguageService.initializeLanguage();
  runApp(const MedicalCityApp());
}
