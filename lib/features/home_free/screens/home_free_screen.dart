import 'package:eurosanpro/common/widgets/appbar/side_by_side_images.dart';
import 'package:eurosanpro/features/authentication/controllers/user_controller.dart';
import 'package:eurosanpro/features/home_free/screens/widgtes/premium_feature_card.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFreeScreen extends StatelessWidget {
  const HomeFreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(TImages.backgroundImageFaded),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(  // Wrapping the whole body in SingleChildScrollView
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Ensures Column shrinks to fit content
            children: [
              // Top image section
              const SideBySideImages(),
              Obx(() => !userController.profileLoading.value
                ? Text(
                    "Welcome ${userController.user.value.firstName}!",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: TSizes.fontSizeLg * 2,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
              ),
              const SizedBox(height: 100),
              // PremiumFeatureCard inside the scrollable area
              Container(
                padding: const EdgeInsets.all(16),
                child: const PremiumFeatureCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
