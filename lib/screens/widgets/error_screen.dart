import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/navigation_routes.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error'.tr)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${'Error'.tr}: ${message.tr}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go(NavigationRoutes.redirect);

              // context.go(NavigationRoutes.redirect);
            },
            child: Text('Retry'.tr),
          ),
        ],
      ),
    );
  }
}
