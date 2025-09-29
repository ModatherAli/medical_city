import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/logger.dart';

final AwesomeNotifications _awesomeNotifications = AwesomeNotifications();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('A bg message just showed up :  ${message.messageId}');
  await Firebase.initializeApp();
}

class NotificationsServices {
  static Future initialize() async {
    await FirebaseMessaging.instance.subscribeToTopic("Users");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // PermissionStatus status = await Permission.notification.requessst();
    // await _awesomeNotifications.requestPermissionToSendNotifications();
    if (!(await Permission.notification.status.isGranted)) {
      // await _awesomeNotifications.requestPermissionToSendNotifications();
      await Get.defaultDialog(
        title: 'الإشعارات',
        middleText: 'إمنح التطبيق الإذن لإرسال الإشعارات',
        textCancel: 'ليس الان',
        textConfirm: 'منح الإذن',
        onConfirm: () async {
          Get.back();
          await _awesomeNotifications.requestPermissionToSendNotifications();
        },
      );
    }
    await _awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel1',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Constants.primaryColor,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        ),
      ],
      debug: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static void receiveNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      print(message.data['post_id']);
      _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: notification.hashCode,
          channelKey: 'basic_channel1',
          title: notification!.title!,
          body: notification.body!,
          actionType: ActionType.Default,
          notificationLayout: NotificationLayout.BigText,
          wakeUpScreen: true,
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      String postId = message.data['post_id'];
      if (postId.isNotEmpty) {
        // Get.to(PostViewScreen(postID: postId));
      }
    });
  }

  static Future<void> sendTopicNotification({
    required String title,
    required String body,
    String topic = 'Users',
  }) async {
    final Map<String, dynamic> message = {
      'topic': topic,
      'notification': {'title': title, 'body': body},
    };

    await sendNotification(message: message);
  }

  static Future<void> sendDeviceNotification({
    required String title,
    required String body,
    required String token,
  }) async {
    final Map<String, dynamic> message = {
      'token': token,
      'notification': {'title': title, 'body': body},
    };

    await sendNotification(message: message);
  }

  static Future<void> sendNotification({
    required Map<String, dynamic> message,
  }) async {
    final credentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "readers-app-2024",
      "private_key_id": "e0b2650e469d5c41d6ee984b6aec400a8b10d010",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDwgyzMAqtuklUl\nDXAQhgtfJF+mZVLmVJkIC4IF5o2jSn/PSYxEexQ5gypamfm2iP2KROetNUVGpoCW\n7kud39q4yO4MFLeoAc6t/0J1WNyUv9Hqawocj0NEpqEPyL/p71ub0MxUfguiFIxl\nE7dPUhRE8yWUxZrNKd8AOrEFiSs5jGlESjKi7CakhGz303yUDHQFrcbXCJt8EDso\nVXyZvqVpt698FkpiSAWsV8xfWnjznJVtcvnBGVd1908vpqyLGPhKxdsf0HXK4ZkB\nyq5ZWfm3f9qazoMt83i4x+s7ZCQd9h6Md2aDemUKVtpkKRdwcuPKXmPPeXe55/xQ\nYv8t1LNbAgMBAAECggEAcybCwGx4yqhKFsLfyDF9aVB/cSnq7ndLi4QC/TM81hT5\nq3OxsinhbYXEtfspiUD+bwB9kbrDD8fxIhI2ZwCB9l3RRzx2D/zJiRoBJjDk710F\nsoAMJ89ZrBlBXM7HP8hHaosmAUAV7sR60XwGlHYeWUK22AtiCd+FstTm41kgtlx7\nagU1gWf61Zi/pE4QVwfPbghcDrwTFbDEP9RYeykeRo7GEysgzNdEb5auzj2aGOjp\n+Usknz+9NgZvjoObEohwPO60jbRirYuk5hxR8s1e06G1qNC/VSbTQgpmXTPI03ex\ntY5gKOLbktXkYMPb2d+UwRGyJTw9hE6eaBY5pa1QOQKBgQD/BOIHxnNdsfmTjDhA\nrkTWRXris2ULQeXQ1fDOee5CVJ3uTWQqPoUODgVe0LJVc9FJUbQ/fxEuDA9fpRfr\nr3XaL2tbkhppK1l+qoUrm0U5FQhtTbnrKbdM/USvD8lmxiFa+e9tttO4kD7TCnz3\nq5ghMM2AfRKtZp1DRp4q5yzl6QKBgQDxcAHhpegOOwgoMkPo++BbmvS7uF35oawi\noFpjtnKP91VImNwBJR6VULcgst/DE0qUB6ICdIw074tlFIQcDxos7JN0T8RAITMT\ny6ho/ycAoa3MXss0ehxfe/myPQF6XLGLoVBkmS133jOYYu0uQ92nzBn4Cp9CQQPo\nUwqLIknQowKBgB+UxzkXRmowBCxVjRHVgwjWCeXROY4vVvqJxAyN5Qep2vUL+H+S\nxn97FQcs6SjT8vMVfzDt137QV4cMtu2lCP9AKBdq/IJRr/+TtnI0BFqRVD3VBlUt\nEVojc0IKvnJPzwmpMhFwNsAAfQc9oUQ6p9hUZt6mno2Cy67tK+E8R78hAoGBAMwa\nn0yN/5YAK44nqCdOv0VRwvDrFG7TUPzYyHEhLMouEifUKbDCG4+o85cuAGIebd6k\ncT5YHqslkpb5+BDsZ3lw6drbEBISvuZONenFQciT5aQuwuRzEodZ/CXE0voJYIKk\n9ZyFrd12t/FsOAvzjW+r6Iw7FpVg9xexE+m5K+O3AoGAO2+4geXmHWrNBKq+wXjc\ng8FtxGa5uSrrhVajvEbauQp0tTnxgGB+wzy5iLlCeLtMISGSUF7FFQu+/2iWtcMa\nVfjGoAg5jzxKpRfA/+Hz8NC4j3Z4iqB04fmdF6wQggdckC57XKS3Tinn7IldBJPr\nlNFQVeV4zL5vXM7EFd+BrlU=\n-----END PRIVATE KEY-----\n",
      "client_email": "notifications@readers-app-2024.iam.gserviceaccount.com",
      "client_id": "111627166870505160485",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/notifications%40readers-app-2024.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    });

    final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    // Get an authenticated HTTP client
    final client = await clientViaServiceAccount(credentials, scopes);

    final accessToken = client.credentials.accessToken.data;

    const String url =
        'https://fcm.googleapis.com/v1/projects/readers-app-2024/messages:send';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      // body: dataNotifications
      body: jsonEncode(<String, dynamic>{'message': message}),
    );

    if (response.statusCode == 200) {
      Logger.print('Notification sent successfully');
      Logger.print(response.body);
    } else {
      Logger.print('Failed to send notification: ${response.statusCode}');
      Logger.print('Response: ${response.body}');
    }

    client.close();
  }
}
