import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:flutter/material.dart';

class NumberWithText extends StatelessWidget {
  const NumberWithText({
    super.key,
    required this.number,
  })  : assert(number >= 0 && number <= 365, 'Number must be between 0 and 365');

  final int number;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: TColors.primary,
              width: 6,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number.toString(),
                style: const TextStyle(
                  color: TColors.primary,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'days left',
                style: TextStyle(
                  color: TColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
}
