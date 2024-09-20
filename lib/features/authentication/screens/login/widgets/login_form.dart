import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/features/authentication/controllers/login_controller.dart';
import 'package:eurosanpro/features/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:eurosanpro/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
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
                  validator: (value) => TValidator.validateEmptyText('Password', value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.lock),
                    labelText: TTexts.password,
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value ? CupertinoIcons.eye_slash : CupertinoIcons.eye)),
                  ),
                ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) {controller.rememberMe.value = !controller.rememberMe.value;}
                      ),
                    ),
                    const Text(TTexts.rememberMe),
                  ]
                ),
                TextButton(onPressed: () => Get.to(() => const ForgotPasswordScreen()), child: Text(TTexts.forgotPassword, style: TextStyle(color: Colors.grey[500])))
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: TSizes.buttonWidth,
              child: ElevatedButton(
                  onPressed: () => controller.emailAndPasswordSignIn(),
                  child: const Text(TTexts.tLogin)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
