import 'dart:io';

import 'package:flutter/material.dart';

class Constants {
  // static const String baseURL = 'https://fcm.googleapis.com/fcm/send';

  // static const String keyServer =
  //     'AAAAdbM6V6Q:APA91bGpQDqrniMM3nCt-EyNApoIsx8uQZgR7-wYa9YZLkyrsajzbcq05-RwT46YYnmUt9c1QNcNDDCw1wTEHAN9b0ikhduhr2p_eqEX53kV77xjLnFW3XOUqUjiM2HH5lBG-la98ZYT';
  // static const String senderID = '505518118820';

  static const String aboutUsUrl = '';
  static const String privacyPolicyUrl =
      'https://www.freeprivacypolicy.com/live/848cd515-dc18-48bd-8e28-3a69ad5f2ad5';
  static const String contactEmail = 'mailto:modather0ali@gmail.com';

  static const String websiteUrl = 'https://riwayat.app/';

  static const String googlePlayUrl =
      'https://play.google.com/store/apps/details?id=modatherali.com.stox';

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
