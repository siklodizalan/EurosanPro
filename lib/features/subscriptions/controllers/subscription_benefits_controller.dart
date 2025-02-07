import 'package:eurosanpro/common/controllers/sliding_stepper_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionBenefitsController extends GetxController implements SlidingStepperBaseController {
  static SubscriptionBenefitsController get instance => Get.find();

  @override
  final pageController = PageController();

  @override
  final pageCount = 5;

  @override
  Rx<int> currentPageIndex = 0.obs;

  @override
  void updatePageIndicator(index) => currentPageIndex.value = index;

  @override
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index as double);
  }

  @override
  void nextPage() {
    if (currentPageIndex.value == pageCount - 1) {
      skipPage();
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  @override
  void skipPage() {
    Get.back();
  }
}