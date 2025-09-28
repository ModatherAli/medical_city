import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String icon;
  final String title;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Using a placeholder icon since the asset is not available
            const Icon(Icons.medical_services),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}