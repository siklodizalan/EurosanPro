import 'package:eurosanpro/features/authentication/controllers/register_controller.dart';
import 'package:eurosanpro/features/authentication/screens/register/widgets/policy_text_page.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:eurosanpro/utils/helpers/helper_functions.dart';
import 'package:eurosanpro/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TRegisterForm extends StatelessWidget {
  const TRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: controller.registerFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(prefixIcon: Icon(CupertinoIcons.mail), labelText: TTexts.email),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) => TValidator.validatePassword(value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      labelText: TTexts.password,
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon: controller.hidePassword.value ? const Icon(CupertinoIcons.eye_slash) : const Icon(CupertinoIcons.eye)
                      )
                  ),
                ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            Obx(
                () => TextFormField(
                  controller: controller.confirmPassword,
                  validator: (value) => TValidator.validateConfirmPassword(value, controller.password.text),
                  obscureText: controller.hideConfirmPassword.value,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      labelText: TTexts.confirmPassword,
                      suffixIcon: IconButton(
                          onPressed: () => controller.hideConfirmPassword.value = !controller.hideConfirmPassword.value,
                          icon: controller.hideConfirmPassword.value ? const Icon(CupertinoIcons.eye_slash) : const Icon(CupertinoIcons.eye)
                      )
                  ),
                ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            Row(
                children: [
                  Obx(() => Checkbox(
                      value: controller.privacyPolicy.value,
                      onChanged: (value) {
                        controller.privacyPolicy.value = !controller.privacyPolicy.value;
                      })
                  ),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: '${TTexts.iAgreeTo} ',
                          style: Theme.of(context).textTheme.labelSmall),
                      TextSpan(
                          text: TTexts.privacyPolicy,
                          style: Theme.of(context).textTheme.labelMedium!.apply(
                              color: dark ? TColors.white : TColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: dark ? TColors.white : TColors.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(PolicyTextPage(
                                  titleText: TTexts.privacyPolicy,
                                  policyText: TTexts.privacyPolicyText)
                              );
                            }),
                      TextSpan(
                          text: '\n${TTexts.and} ',
                          style: Theme.of(context).textTheme.labelSmall),
                      TextSpan(
                        text: TTexts.termsOfUse,
                        style: Theme.of(context).textTheme.labelMedium!.apply(
                            color: dark ? TColors.white : TColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: dark ? TColors.white : TColors.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(PolicyTextPage(
                                titleText: TTexts.termsOfUse,
                                policyText: TTexts.termsOfUseText)
                            );
                          },
                      ),
                    ]),
                  ),
                ]
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: TSizes.buttonWidth,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(TTexts.tSignUp)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
