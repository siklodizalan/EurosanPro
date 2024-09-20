import 'package:eurosanpro/common/widgets/custom_header.dart';
import 'package:eurosanpro/common/widgets/form_question.dart';
import 'package:eurosanpro/features/authentication/screens/login/login_screen.dart';
import 'package:eurosanpro/features/authentication/screens/register/widgets/register_form.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:eurosanpro/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: THelperFunctions.screenHeight(context) / 8),
              const TCustomHeader(text: TTexts.letsCreateAccount),
              const TRegisterForm(),
              TFormQuestion(onTap: () => Get.to(() => const LoginScreen()), text: TTexts.alreadyHaveAnAccount, buttonText: TTexts.logInNow),
              SizedBox(height: THelperFunctions.screenHeight(context) / 8),
            ],
          ),
        ),
      ),
    );
  }
}
