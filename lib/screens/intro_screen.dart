import 'package:flutter/material.dart';

import 'widgets/app_description.dart';
import 'widgets/background_image.dart';
import 'widgets/start_auth_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () => showLanguageSelection(context),
      //     icon: Icon(Icons.translate),
      //   ),
      //   backgroundColor: Colors.transparent,
      // ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              // padding: const EdgeInsets.symmetric(horizontal: 16),
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(height: 100),
                AppDescription(),
                const SizedBox(height: 15),
                StartAuthButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
