import 'package:eurosanpro/common/controllers/sliding_stepper_base_controller.dart';
import 'package:eurosanpro/common/widgets/buttons/next_button.dart';
import 'package:eurosanpro/common/widgets/slidingStepper/widgets/dot_navigation.dart';
import 'package:eurosanpro/common/widgets/slidingStepper/widgets/step_page.dart';
import 'package:eurosanpro/common/widgets/slidingStepper/widgets/step_skip.dart';
import 'package:flutter/material.dart';

class SlidingStepper extends StatelessWidget {
  const SlidingStepper({
    super.key,
    required this.controller,
    required this.pages,
  });

  final SlidingStepperBaseController controller;
  final List<SlidingStepperPage> pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: pages
          ),
          SlidingSkip(onSkip: controller.skipPage),
          SlidingStepperDotNavigation(pageController: controller.pageController, onDotClicked: controller.dotNavigationClick, pageCount: controller.pageCount),
          NextButton(nextPage: controller.nextPage),
        ],
      ),
    );
  }
}