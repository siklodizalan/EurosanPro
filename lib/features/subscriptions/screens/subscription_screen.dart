import 'package:eurosanpro/common/widgets/appbar/side_by_side_images.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/call_to_action.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/difference_section.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/logo.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    CallToActionButton(
                      buttonText: 'GET IT NOW!',
                      subText: 'over 93.2% of users chose this plan',
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    const DifferenceSection(
                      title: 'Care este diferenta dintre ANUAL si LUNAR?',
                      description:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at facilisis neque. Nulla varius massa a libero tempor, nec ultricies nulla viverra.',
                    ),
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
