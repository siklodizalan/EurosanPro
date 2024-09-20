import 'package:eurosanpro/common/loaders/animation_loader.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TAnimationLoaderWidget(text: text, animation: animation),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
