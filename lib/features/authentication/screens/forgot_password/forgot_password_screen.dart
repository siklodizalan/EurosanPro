import 'package:eurosanpro/common/widgets/appbar/appbar.dart';
import 'package:eurosanpro/features/authentication/controllers/forgot_password_controller.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:eurosanpro/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Container(
      color: Colors.black,
      child: Center(
          child: Scaffold(
            appBar: TAppBar(
                showBackArrow: true,
                title: Text(TTexts.resetPassword)),
            body: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Headings
                  Text(
                    TTexts.forgotPasswordTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    TTexts.forgotPasswordSubtitle,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2),

                  /// Text field
                  Form(
                    key: controller.forgetPasswordFormKey,
                    child: TextFormField(
                      controller: controller.email,
                      validator: TValidator.validateEmail,
                      decoration: InputDecoration(
                          labelText: TTexts.email,
                          prefixIcon: const Icon(CupertinoIcons.mail)),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.sendPasswordResetEmail(),
                        child: Text(TTexts.submit)),
                  )
                ],
              ),
            ),
          ),
        ),

    );
  }
}
