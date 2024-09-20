import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/data/repositories/user/user_repository.dart';
import 'package:eurosanpro/features/authentication/models/user_model.dart';
import 'package:eurosanpro/features/contract_upload/screens/contract_upload_screen.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/helpers/network_manager.dart';
import 'package:eurosanpro/utils/popups/full_screen_loader.dart';
import 'package:eurosanpro/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  /// -- SIGNUP
  void signup() async {
    try {
      TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!registerFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create an account, you must have to read and accept the Privacy Policy & Terms of Use.'
        );
        return;
      }

      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      final newUser = UserModel(
        id: userCredential.user!.uid,
        name: '',
        cnp: '',
        city: '',
        country: '',
        address: '',
        phoneNumber: '',
        loginEmail: email.text.trim(),
        contractEmail: '',
      );

      final userRepository = UserRepository.instance;
      userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(title: 'Congratulations!', message: 'Your account has been created!');

      Get.to(() => const ContractUploadScreen());

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}