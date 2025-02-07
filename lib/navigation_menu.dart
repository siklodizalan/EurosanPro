import "package:eurosanpro/common/loaders/animation_loader.dart";
import "package:eurosanpro/features/authentication/controllers/user_controller.dart";
import "package:eurosanpro/features/contract/controllers/contract_controller.dart";
import "package:eurosanpro/features/home/screens/home_screen.dart";
import "package:eurosanpro/features/home_free/screens/home_free_screen.dart";
import "package:eurosanpro/features/subscriptions/controllers/subscription_controller.dart";
import "package:eurosanpro/features/subscriptions_v2/screens/subscription_details/subscription_details_screen.dart";
import "package:eurosanpro/features/subscriptions_v2/screens/subscription_sale/subscription_screen_v2.dart";
import "package:eurosanpro/utils/constraints/colors.dart";
import "package:eurosanpro/utils/constraints/image_strings.dart";
import "package:eurosanpro/utils/helpers/helper_functions.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final darkMode = THelperFunctions.isDarkMode(context);

    return Obx(
          () {
        final userRole = userController.user.value.role;
        if (userRole.isEmpty) {
          return const TAnimationLoaderWidget(
              text: 'Getting ready...', animation: TImages.docerAnimation);
        } else {
          final controller = Get.put(NavigationController());
          return Scaffold(
            bottomNavigationBar: Obx(
                  () => NavigationBar(
                height: 60,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
                backgroundColor: darkMode ? TColors.black : Colors.white,
                indicatorColor: darkMode
                    ? TColors.white.withOpacity(0.1)
                    : TColors.black.withOpacity(0.1),
                destinations: userController.user.value.role == "ADMIN"
                    ? [
                  const NavigationDestination(
                      icon: Icon(CupertinoIcons.house_fill),
                      label: 'Home'),
                  const NavigationDestination(
                      icon: Icon(CupertinoIcons.star_fill),
                      label: 'Subscription'),
                  const NavigationDestination(
                      icon: Icon(CupertinoIcons.settings_solid),
                      label: 'Admin'),
                ]
                    : [
                  const NavigationDestination(
                      icon: Icon(CupertinoIcons.house_fill),
                      label: 'Home'),
                  const NavigationDestination(
                      icon: Icon(CupertinoIcons.star_fill),
                      label: 'Subscription'),
                ],
              ),
            ),
            body: Obx(() => controller.screens[controller.selectedIndex.value]),
          );
        }
      },
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final List<Widget> screens;
  NavigationController() : screens = getScreens();

  void goToPage(int index) {
    selectedIndex.value = index;
  }

  void reloadNavigation() {
    if (ContractController.instance.contract.value.id.isNotEmpty) {
      selectedIndex.value = 0;
      screens[0] = const HomeScreen();
      screens[1] = const SubscriptionDetailsScreen();
    }
  }
}

List<Widget> getScreens() {
  final userController = UserController.instance;
  final contractController = ContractController.instance;
  final subscriptionController = SubscriptionController.instance;

  bool hasContract = contractController.contract.value.id.isNotEmpty;
  bool hasSubscription = subscriptionController.subscription.value.id.isNotEmpty;

  return userController.user.value.role == "ADMIN"
      ? [
    hasContract ? const HomeScreen() : const HomeFreeScreen(),
    //hasContract ? const ContractDetailsScreen() : const ContractUploadScreen(),
    //const SubscriptionScreen(),
    hasSubscription ? const SubscriptionDetailsScreen() : const SubscriptionScreenV2(),
    const HomeScreen(),
  ]
      : [
    hasContract ? const HomeScreen() : const HomeFreeScreen(),
    //hasContract ? const ContractDetailsScreen() : const ContractUploadScreen(),
    //const SubscriptionScreen(),
    hasSubscription ? const SubscriptionDetailsScreen() : const SubscriptionScreenV2(),
  ];
}
