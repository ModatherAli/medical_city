import 'package:flutter/material.dart';

import '../res/images_paths.dart';

class AppIconWidget extends StatelessWidget {
  final double size;
  const AppIconWidget({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      child: Hero(
        tag: 'app_icon',
        child: Image.asset(ImagesPaths.appIcon, height: size),
      ),
    );
  }
}
