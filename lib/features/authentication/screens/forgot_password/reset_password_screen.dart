import 'package:eurosanpro/features/authentication/controllers/forgot_password_controller.dart';
import 'package:eurosanpro/features/authentication/screens/login/login_screen.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:eurosanpro/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Image(
                      image: AssetImage(
                          dark ? TImages.eurosanProLogo : TImages.eurosanProLogoDark),
                      width: THelperFunctions.screenWidth() * 0.6),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  Text(
                    TTexts.changeYourPasswordTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    TTexts.changeYourPasswordSubtitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => Get.offAll(() => const LoginScreen()),
                        child: Text(TTexts.done)),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () => ForgetPasswordController.instance
                            .resendPasswordResetEmail(email),
                        child: Text(TTexts.resendEmail)),
                  ),
                ],
              ),
            ),
          ),

      ),
    );
  }
}
