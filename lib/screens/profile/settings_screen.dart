import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: const Text('Notification Setting'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.push(NavigationRoutes.notificationSettings);
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Password Manager'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Delete Account'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
