import "package:eurosanpro/common/loaders/animation_loader.dart";
import "package:eurosanpro/features/authentication/controllers/user_controller.dart";
import "package:eurosanpro/features/home/screens/home_screen.dart";
import "package:eurosanpro/features/subscriptions/screens/subscription_screen.dart";
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
                height: 80,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
                backgroundColor: darkMode ? TColors.black : Colors.white,
                indicatorColor: darkMode
                    ? TColors.white.withOpacity(0.1)
                    : TColors.black.withOpacity(0.1),
                destinations: userController.user.value.role == "ADMIN"
                    ? const [
                  NavigationDestination(
                      icon: Icon(CupertinoIcons.house_fill),
                      label: 'Home'),
                  NavigationDestination(
                      icon: Icon(CupertinoIcons.star_fill),
                      label: 'Subscriptions'),
                  NavigationDestination(
                      icon: Icon(CupertinoIcons.settings_solid),
                      label: 'Admin'),
                ]
                    : const [
                  NavigationDestination(
                      icon: Icon(CupertinoIcons.house_fill),
                      label: 'Home'),
                  NavigationDestination(
                      icon: Icon(CupertinoIcons.star_fill),
                      label: 'Subscriptions'),
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
}

List<Widget> getScreens() {
  final userController = UserController.instance;
  return userController.user.value.role == "ADMIN"
      ? [
    const HomeScreen(),
    SubscriptionScreen(),
    const HomeScreen(),
  ]
      : [
    const HomeScreen(),
    SubscriptionScreen(),
  ];
}
