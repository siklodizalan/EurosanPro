import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color = TColors.primary
  });

  final Function()? onTap;
  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: TSizes.fontSizeLg, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
