import 'package:flutter/material.dart';

class DectorCard extends StatelessWidget {
  const DectorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Doctor Card Placeholder'),
      ),
    );
  }
}