import 'package:flutter/material.dart';

class OtherAuthIconButtons extends StatelessWidget {
  const OtherAuthIconButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.g_mobiledata), // Placeholder for Google
          onPressed: () {
            // TODO: Implement Google Sign-In
          },
        ),
        IconButton(
          icon: const Icon(Icons.facebook), // Placeholder for Facebook
          onPressed: () {
            // TODO: Implement Facebook Sign-In
          },
        ),
        IconButton(
          icon: const Icon(Icons.apple), // Placeholder for Apple
          onPressed: () {
            // TODO: Implement Apple Sign-In
          },
        ),
      ],
    );
  }
}