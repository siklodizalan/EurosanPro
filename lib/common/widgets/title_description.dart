import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({
    super.key,
    required this.title,
    required this.description
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: TSizes.fontSizeLg * 0.6)
          ),
          Text(
              description,
              style: const TextStyle(color: Colors.white, fontSize: TSizes.fontSizeLg)
          ),
          const SizedBox(height: TSizes.sm)
        ],
      ),
    );
  }
}
