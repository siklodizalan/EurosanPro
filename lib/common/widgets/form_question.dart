import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:flutter/material.dart';

class TFormQuestion extends StatelessWidget {
  const TFormQuestion({
    super.key,
    required this.onTap,
    required this.text,
    required this.buttonText
  });

  final Function()? onTap;
  final String text;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.grey[500]),
        ),
        TextButton(onPressed: onTap, child: Text(
          buttonText,
          style: const TextStyle(color: TColors.primary, fontWeight: FontWeight.bold),
        )),
      ],
    );
  }
}
