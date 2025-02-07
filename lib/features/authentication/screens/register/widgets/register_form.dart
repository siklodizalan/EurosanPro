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
            /// First & Last Name
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) => TValidator.validateEmptyText(
                        TTexts.firstName, value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.firstName,
                        prefixIcon: Icon(CupertinoIcons.person)),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwInputFields / 2),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) => TValidator.validateEmptyText(
                        TTexts.lastName, value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.lastName,
                        prefixIcon: Icon(CupertinoIcons.person)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value?.trim()),
              decoration: const InputDecoration(prefixIcon: Icon(CupertinoIcons.mail), labelText: TTexts.email),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Phone Number
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => TValidator.validatePhoneNumber(value?.trim()),
              decoration: const InputDecoration(
                labelText: TTexts.phoneNumber,
                prefixIcon: Icon(CupertinoIcons.phone)
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Password
            Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) => TValidator.validatePassword(value?.trim()),
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

            /// Terms and Conditions
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
                              Get.to(const PolicyTextPage(
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
                            Get.to(const PolicyTextPage(
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

            /// Sign-up Button
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
