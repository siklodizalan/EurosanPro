import 'package:eurosanpro/data/repositories/user/user_repository.dart';
import 'package:eurosanpro/features/authentication/controllers/user_controller.dart';
import 'package:eurosanpro/features/contract_upload/controllers/contract_controller.dart';
import 'package:eurosanpro/features/subscriptions/controllers/subscription_controller.dart';
import 'package:eurosanpro/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(UserController());
    Get.put(ContractController());
    Get.put(SubscriptionController());
  }
}
