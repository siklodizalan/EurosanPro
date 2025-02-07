import 'package:eurosanpro/common/controllers/sliding_stepper_base_controller.dart';
import 'package:eurosanpro/common/widgets/appbar/side_by_side_images.dart';
import 'package:eurosanpro/common/widgets/number_text.dart';
import 'package:eurosanpro/common/widgets/slidingStepper/sliding_stepper.dart';
import 'package:eurosanpro/common/widgets/slidingStepper/widgets/step_page.dart';
import 'package:eurosanpro/features/subscriptions/controllers/subscription_benefits_controller.dart';
import 'package:eurosanpro/features/subscriptions/controllers/subscription_controller.dart';
import 'package:eurosanpro/features/subscriptions/models/subscription_model.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/logo.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';

class SubscriptionDetailsScreen extends StatelessWidget {
  const SubscriptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subscriptionController = SubscriptionController.instance;

    final pages = [
      const SlidingStepperPage(
        labelImage: TImages.eurosanProLogo,
        backgroundImage: TImages.backgroundImageFaded,
        mainImage: TImages.eurosanProLogo,
        title: "Title",
        subTitle: "Description",
      ),
      const SlidingStepperPage(
        backgroundColor: Colors.black,
        mainImage: TImages.eurosanProLogo,
        title: "Title",
        subTitle: "Description",
      ),
      const SlidingStepperPage(
        backgroundColor: Colors.black,
        mainImage: TImages.eurosanProLogo,
        title: "Title",
        subTitle: "Description",
      ),
      const SlidingStepperPage(
        backgroundColor: Colors.black,
        mainImage: TImages.eurosanProLogo,
        title: "Title",
        subTitle: "Description",
      ),
      const SlidingStepperPage(
        backgroundColor: Colors.black,
        mainImage: TImages.eurosanProLogo,
        title: "Title",
        subTitle: "Description",
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(TImages.backgroundImageFaded),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SideBySideImages(),
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const Logo(imagePath: TImages.eurosanProLogo),
                    const SizedBox(height: 20),
                    const NumberWithText(number: 360),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (subscriptionController.subscriptionLoading.value) {
                        return const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        );
                      }

                      final subscription = subscriptionController.subscription.value;

                      return _SubscriptionDataDisplay(subscription: subscription, pages: pages);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubscriptionDataDisplay extends StatelessWidget {
  const _SubscriptionDataDisplay({
    required this.subscription,
    required this.pages,
  });
  
  final SubscriptionModel? subscription;

  final List<SlidingStepperPage> pages;

  @override
  Widget build(BuildContext context) {
    SlidingStepperBaseController subscriptionBenefitsController = Get.put<SlidingStepperBaseController>(SubscriptionBenefitsController());

    return subscription == null
        ? const Text("No subscription data available", style: TextStyle(color: Colors.white))
        : Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.primary, width: 1),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.6),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSubscriptionDetailRow('Package Name', subscription!.title),
                        _buildSubscriptionDetailRow('Start Date', subscription!.startDate),
                        _buildSubscriptionDetailRow('Length', subscription!.length),
                        _buildSubscriptionDetailRow('Next Billing Date', subscription!.nextBillingDate),
                        _buildSubscriptionDetailRow('Price', '${subscription!.price} ${subscription!.currencyCode}'),
                        _buildSubscriptionDetailRow('Identifier', subscription!.packageIdentifier),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: const Text('View subscription benefits', style: TextStyle(color: TColors.primary)),
                          onPressed: () => {
                            subscriptionBenefitsController.currentPageIndex.value = 0,
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              subscriptionBenefitsController.pageController.jumpToPage(0);
                            }),
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => SlidingStepper(controller: subscriptionBenefitsController, pages: pages),
                              ),
                            ),
                          },
                        ),
                        TextButton(
                          child: const Text('Manage subscription', style: TextStyle(color: TColors.primary)),
                          onPressed: () => {},
                        ),
                      ],
                    ),
                  ],
                ),
              ), 
            ],
          );
  }

  Widget _buildSubscriptionDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
