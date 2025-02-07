import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

abstract class SlidingStepperBaseController {
  PageController get pageController;
  int get pageCount;
  Rx<int> get currentPageIndex;

  void updatePageIndicator(int index);
  void dotNavigationClick(int index);
  void nextPage();
  void skipPage();
}