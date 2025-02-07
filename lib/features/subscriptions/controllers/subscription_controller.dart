import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/data/repositories/subscription/subscription_repository.dart';
import 'package:eurosanpro/features/authentication/controllers/user_controller.dart';
import 'package:eurosanpro/features/subscriptions/models/subscription_model.dart';
import 'package:eurosanpro/features/subscriptions_v2/controllers/offerings_controller.dart';
import 'package:eurosanpro/navigation_menu.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController get instance => Get.find();

  final subscriptionLoading = false.obs;
  Rx<SubscriptionModel> subscription = SubscriptionModel.empty().obs;
  final subscriptionRepository = Get.put(SubscriptionRepository());
  final userController = UserController.instance;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionRecord();
  }

  Future<void> fetchSubscriptionRecord() async {
    try {
      subscriptionLoading.value = true;
      this.subscription(SubscriptionModel.empty());
      final subscription = await subscriptionRepository.fetchSubscriptionDetails();
      this.subscription(subscription);
    } catch (e) {
      subscription(SubscriptionModel.empty());
    } finally {
      subscriptionLoading.value = false;
    }
  }

  Future<void> purchasePackage(String storeProductIdentifier) async {
    final navigationController = Get.find<NavigationController>();
    final offeringsController = OfferingsController.instance;
    try {
      final selectedOffering = offeringsController.offerings.first;

      final package = selectedOffering.availablePackages.firstWhere(
        (pkg) => pkg.storeProduct.identifier == storeProductIdentifier,
      );

      final purchaserInfo = await Purchases.purchasePackage(package);

      if (purchaserInfo.activeSubscriptions.isNotEmpty) {
          final latestPurchaseDate = purchaserInfo.allPurchaseDates[storeProductIdentifier];
          final latestExpirationDate = purchaserInfo.allExpirationDates[storeProductIdentifier];

          final currentUser = AuthenticationRepository.instance.authUser;

          

          final subscription = SubscriptionModel(
          id: '',
          userId: currentUser!.uid,
          startDate: latestPurchaseDate ?? '',
          length: package.storeProduct.subscriptionPeriod ?? '',
          nextBillingDate: latestExpirationDate ?? '',
          price: package.storeProduct.price,
          packageIdentifier: package.identifier,
          storeProductIdentifier: storeProductIdentifier,
          title: package.storeProduct.title,
          currencyCode: package.storeProduct.currencyCode,
        );

        await subscriptionRepository.saveSubscription(subscription);
  
        navigationController.goToPage(0);
      }
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print('Purchase cancelled');
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print('Purchase not allowed');
      } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
        print('Payment is pending');
      } else {
        print('Purchase failed: ${e.message}');
      }
    }
  }
}