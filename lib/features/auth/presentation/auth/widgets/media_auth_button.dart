import 'package:flutter/material.dart';

class MediaAuthButton extends StatelessWidget {
  final Color? color;
  final IconData iconData;
  final void Function()? onTap;
  const MediaAuthButton({
    super.key,
    this.color,
    required this.iconData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: const CircleBorder(),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(
            iconData,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
