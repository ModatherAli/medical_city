import 'dart:io';

import 'package:flutter/material.dart';

class Constants {
  static const String aboutUsUrl = '';
  static const String privacyPolicyUrl = '';
  static const String contactEmail = 'mailto:modather0ali@gmail.com';

  static const String googlePlayUrl =
      'https://play.google.com/store/apps/details?id=';

  static const String appStoreUrl = '';

  static const MaterialColor primaryColor = Colors.blue;
  static const Color darkColor = Color(0xFF1d3557);
  static const Color primaryDarkColor = Color(0xFF0d1b2a);
  static const Color goldColor = Color(0xFFFFD700); // Define golden color

  static String getAppUrl() {
    if (Platform.isAndroid) {
      return googlePlayUrl;
    } else {
      return appStoreUrl;
    }
  }
}
