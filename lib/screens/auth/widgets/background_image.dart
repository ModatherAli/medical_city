import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../shared/res/images_paths.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      ImagesPaths.background,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
