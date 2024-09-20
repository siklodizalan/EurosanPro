import 'package:eurosanpro/common/widgets/custom_header.dart';
import 'package:eurosanpro/common/widgets/form_question.dart';
import 'package:eurosanpro/features/authentication/screens/login/widgets/login_form.dart';
import 'package:eurosanpro/features/authentication/screens/register/register_screen.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:eurosanpro/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: THelperFunctions.screenHeight(context) / 6),
              const TCustomHeader(text: TTexts.welcomeBack),
              const TLoginForm(),
              TFormQuestion(onTap: () => Get.to(() => const RegisterScreen()), text: TTexts.notAMember, buttonText: TTexts.registerNow),
              SizedBox(height: THelperFunctions.screenHeight(context) / 10),
            ],
          ),
        ),
      ),
    );
  }
}
