import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_city/shared/res/images_paths.dart';

class OtherAuthIconButtons extends StatelessWidget {
  const OtherAuthIconButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Or divider
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or contine with'.tr,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // context.go(NavigationRoutes.main);
              },
              icon: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagesPaths.nafadhIcon),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                // context.go(NavigationRoutes.main);
              },
              icon: Card(child: Icon(Icons.face, size: 50)),
            ),
          ],
        ),
      ],
    );
  }
}
