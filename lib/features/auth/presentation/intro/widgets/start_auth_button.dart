import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/navigation_routes.dart';

class StartAuthButton extends StatelessWidget {
  const StartAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () => context.push(NavigationRoutes.signup),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Accept'.tr, style: TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 24),
        ],
      ),
    );
  }
}
