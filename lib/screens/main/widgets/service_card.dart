import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String icon;
  final String title;
  final void Function()? onTap;
  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Card(
            elevation: 1,
            color: Color(0xFF5B9FBF),
            child: Container(
              height: 60,
              width: 60,
              padding: EdgeInsets.all(15),
              child: Image.asset(icon),
            ),
          ),
        ),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
