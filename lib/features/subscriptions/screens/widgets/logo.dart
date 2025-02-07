import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}