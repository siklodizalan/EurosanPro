import 'package:eurosanpro/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';

class PlanOption extends StatelessWidget {
  final String title;
  final String price;
  final String badgeText;
  final bool isSelected;

  const PlanOption({
    required this.title,
    required this.price,
    required this.badgeText,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: THelperFunctions.screenWidth() * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? TColors.primary : Colors.grey, width: isSelected ? 2 : 1),
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.6),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            price,
            style: const TextStyle(color: Colors.white70),
          ),
          if (badgeText.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badgeText,
                style: const TextStyle(color: TColors.primary, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

