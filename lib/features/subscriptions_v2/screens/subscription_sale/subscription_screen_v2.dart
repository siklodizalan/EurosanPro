import 'package:eurosanpro/common/widgets/appbar/side_by_side_images.dart';
import 'package:eurosanpro/features/authentication/screens/register/widgets/policy_text_page.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/call_to_action.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/logo.dart';
import 'package:eurosanpro/features/subscriptions_v2/controllers/offerings_controller.dart';
import 'package:eurosanpro/features/subscriptions_v2/screens/subscription_sale/widgets/feature_item.dart';
import 'package:eurosanpro/features/subscriptions_v2/screens/subscription_sale/widgets/plan_option.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionScreenV2 extends StatefulWidget {
  const SubscriptionScreenV2({super.key});

  @override
  _SubscriptionScreenV2State createState() => _SubscriptionScreenV2State();
}

class _SubscriptionScreenV2State extends State<SubscriptionScreenV2> {
  String? selectedPackageIdentifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background and scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height / 4,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(TImages.backgroundImageFaded),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SideBySideImages(),
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        const Logo(imagePath: TImages.eurosanProLogo),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select a Plan',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          final offeringsController = OfferingsController.instance;
                          if (offeringsController.offerings.isEmpty) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          final offering = offeringsController.offerings.first;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: offering.availablePackages.map((package) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPackageIdentifier = package.storeProduct.identifier;
                                  });
                                },
                                child: PlanOption(
                                  title: package.storeProduct.title,
                                  price: '${package.storeProduct.priceString} + TVA',
                                  badgeText: package.storeProduct.description,
                                  isSelected: selectedPackageIdentifier == package.storeProduct.identifier,
                                ),
                              );
                            }).toList(),
                          );
                        }),
                        const SizedBox(height: 20),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Feature list container with border and dark background
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: TColors.primary, width: 1),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black.withOpacity(0.6),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FeatureItem(text: 'Rezolvăm Problemele Rapid', subText: 'Remediere în 72 de Ore!'),
                                  FeatureItem(text: 'Întreținere Gratuită', subText: '2 Revizii Anuale Cadou'),
                                  FeatureItem(text: 'Constatări Gratuite', subText: 'De Două Ori pe An'),
                                  FeatureItem(text: 'Fidelitate Răsplătită', subText: '10% Reducere la Următoarea Comandă'),
                                  FeatureItem(text: 'Acces Exclusiv', subText: 'Alătură-te Clubului EurosanDOOR!'),
                                ],
                              ),
                            ),
                            // "Included with Premium Plan" label
                            Positioned(
                              top: -12,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(color: TColors.primary, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Included with Premium',
                                  style: TextStyle(color: TColors.primary, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.8),
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CallToActionButton(
                    buttonText: 'GET IT NOW!',
                    subText: 'Over 93.2% of users chose this plan',
                    textColor: Colors.white,
                    onPressed: selectedPackageIdentifier != null
                      ? () async {
                          Navigator.pushNamed(context, '/firstQuestion', arguments: {'packageIdentifier': selectedPackageIdentifier});
                        }
                      : () {},
                    enabled: selectedPackageIdentifier != null,
                  ),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${TTexts.byTappingGetItNow} ',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white70)
                        ),
                        TextSpan(
                          text: TTexts.terms,
                          style: Theme.of(context).textTheme.labelMedium!.apply(
                            color: TColors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: TColors.white),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(const PolicyTextPage(
                                titleText: TTexts.termsOfUse,
                                policyText: TTexts.termsOfUseText
                              ),
                            );
                          }
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
