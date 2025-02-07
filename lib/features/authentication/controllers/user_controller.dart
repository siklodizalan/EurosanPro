import 'package:eurosanpro/data/repositories/user/user_repository.dart';
import 'package:eurosanpro/features/authentication/models/user_model.dart';
import 'package:eurosanpro/utils/popups/loaders.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      this.user(UserModel.empty());
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await userRepository.updateUserDetails(updatedUser);
      TLoaders.successSnackBar(title: 'Congratulations!', message: 'Your contract has been uploaded!');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e);
    }
  }
}