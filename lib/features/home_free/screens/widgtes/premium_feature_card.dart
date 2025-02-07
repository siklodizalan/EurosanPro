import 'dart:async';

import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/call_to_action.dart';
import 'package:eurosanpro/navigation_menu.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:get/get.dart';

class PremiumFeatureCard extends StatefulWidget {
  const PremiumFeatureCard({super.key});

  @override
  _PremiumFeatureCardState createState() => _PremiumFeatureCardState();
}

class _PremiumFeatureCardState extends State<PremiumFeatureCard> {
  final shakeKey = GlobalKey<ShakeWidgetState>();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      shakeKey.currentState?.shake();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    child: Center(
                      child: Image.asset(
                          TImages.eurosanProLogo,
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  const Text(
                    'Premium',
                    style: TextStyle(
                      color: TColors.primary,
                      fontSize: TSizes.fontSizeLg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => navigationController.goToPage(1),
                child: const Text(
                  'See all Features',
                  style: TextStyle(
                    color: TColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: [
              _buildTableHeaderRow(),
              _buildFeatureRow("Rezolvăm Problemele Rapid", false, true),
              _buildFeatureRow("Întreținere Gratuită", false, true),
              _buildFeatureRow("2 Constatări Gratuite / An", false, true),
              _buildFeatureRow("Fidelitate Răsplătită", false, true),
              _buildFeatureRow("Acces Exclusiv la Evenimete", false, true),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: ShakeMe(
              key: shakeKey,
              shakeCount: 3,
              shakeOffset: 5,
              shakeDuration: const Duration(milliseconds: 300),
              child: CallToActionButton(
                buttonText: 'UPGRADE',
                fontSize: TSizes.fontSizeXl,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                textColor: Colors.white,
                onPressed: () => navigationController.goToPage(1),
              ),
            ),
          ),
          TextButton(
            child: const Text('LOG OUT', style: TextStyle(color: TColors.primary)),
            onPressed: () => AuthenticationRepository.instance.logout(),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableHeaderRow() {
    return const TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "What's included",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Free",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Premium",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildFeatureRow(String feature, bool freeIncluded, bool premiumIncluded) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            feature,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        _buildCheckOrLine(freeIncluded),
        _buildCheckOrLine(premiumIncluded),
      ],
    );
  }

  Widget _buildCheckOrLine(bool isIncluded) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isIncluded
          ? const Icon(CupertinoIcons.check_mark, color: TColors.primary)
          : const Icon(CupertinoIcons.minus, color: Colors.white),
    );
  }
}
