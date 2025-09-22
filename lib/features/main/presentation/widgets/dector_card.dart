import 'package:flutter/material.dart';

class DectorCard extends StatelessWidget {
  const DectorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      elevation: 0.5,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dr. Manar!!!!!!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text(
                    'Medical File',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'ID #: 4905503',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            const Text(
              'Xxxx',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
