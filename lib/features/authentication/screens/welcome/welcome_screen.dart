import 'package:eurosanpro/features/authentication/screens/login/login_screen.dart';
import 'package:eurosanpro/features/authentication/screens/register/register_screen.dart';
import 'package:eurosanpro/features/contract_upload/screens/contract_upload_screen.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:eurosanpro/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: THelperFunctions.screenHeight(context) / 10,
              ),
              Image(image: AssetImage(dark ? TImages.eurosanProLogo : TImages.eurosanProLogoDark)),
              Column(
                children: [
                  SizedBox(
                    width: TSizes.buttonWidth,
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => const LoginScreen()),
                        child: Text(TTexts.tLogin.toUpperCase())
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    width: TSizes.buttonWidth,
                    child: OutlinedButton(
                        onPressed: () => Get.to(() => const RegisterScreen()),
                        //onPressed: () => Get.to(() => const ContractUploadScreen()),
                        child: Text(TTexts.tSignUp.toUpperCase())
                    ),
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}
