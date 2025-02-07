import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';

class FeatureItem extends StatelessWidget {
  final String text;
  final String? subText;

  const FeatureItem({
    super.key,
    required this.text,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(CupertinoIcons.check_mark, color: TColors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                subText != null ?
                Text(
                  subText!,
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ) : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
