import 'package:eurosanpro/data/repositories/Subscription/Subscription_repository.dart';
import 'package:eurosanpro/features/subscriptions/models/subscription_model.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController get instance => Get.find();

  final subscriptionLoading = false.obs;
  Rx<SubscriptionModel> subscription = SubscriptionModel.empty().obs;
  final subscriptionRepository = Get.put(SubscriptionRepository());

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionRecord();
  }

  Future<void> fetchSubscriptionRecord() async {
    try {
      subscriptionLoading.value = true;
      this.subscription(SubscriptionModel.empty());
      final subscription = await subscriptionRepository.fetchSubscription();
      this.subscription(subscription);
    } catch (e) {
      subscription(SubscriptionModel.empty());
    } finally {
      subscriptionLoading.value = false;
    }
  }
}