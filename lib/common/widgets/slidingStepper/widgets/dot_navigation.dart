import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlidingStepperDotNavigation extends StatelessWidget {
  const SlidingStepperDotNavigation({
    super.key,
    required this.pageController,
    required this.onDotClicked,
    required this.pageCount,
  });

  final PageController pageController;
  final Function(int) onDotClicked;
  final int pageCount; 

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: pageController,
        onDotClicked: onDotClicked,
        count: pageCount,
        effect: const ExpandingDotsEffect(
            activeDotColor: Colors.white, dotHeight: 6),
      ),
    );
  }
}