import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class SlidingSkip extends StatelessWidget {
  const SlidingSkip({
    super.key,
    required this.onSkip,
  });

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: TSizes.defaultSpace,
        child: TextButton(
          onPressed: onSkip,
          child: Text("Skip", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TColors.primary)),
        ));
  }
}