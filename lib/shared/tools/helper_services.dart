import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class HelperServices {
  static void lunchUrl(String link) async {
    Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  static String dateFormatter(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  static void copyValue(BuildContext context, {required dynamic value}) {
    Clipboard.setData(ClipboardData(text: '$value'));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Copied $value')));
  }

  static Future<void> vibrate() async {
    bool hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator) {
      Vibration.vibrate(duration: 50);
    }
  }

  static Future<void> share(
    String text, {
    required BuildContext context,
  }) async {
    if (Platform.isAndroid) {
      SharePlus.instance.share(ShareParams(text: text));
    } else {
      var box = context.findRenderObject() as RenderBox?;
      SharePlus.instance.share(
        ShareParams(
          text: text,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        ),
      );
    }
  }

  static Future<bool> checkConnectivity({bool showAlert = true}) async {
    late List<ConnectivityResult> connectivityResult;
    connectivityResult = await Connectivity().checkConnectivity();

    bool isConnected =
        connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);

    if (!isConnected && showAlert) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد اتصال بالإنترنت'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    return isConnected;
  }
}
