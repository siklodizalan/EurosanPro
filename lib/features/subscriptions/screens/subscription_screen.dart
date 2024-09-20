import 'package:eurosanpro/common/widgets/appbar/side_by_side_images.dart';
import 'package:eurosanpro/features/subscriptions/controllers/subscription_controller.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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
          //padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SideBySideImages(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                        TImages.eurosanProLogo,
                        fit: BoxFit.cover
                    ),
                    SizedBox(height: 20),
                    CheckList(),
                    SizedBox(height: 20),
                    PriceSection(),
                    SizedBox(height: 20),
                    CallToAction(),
                    SizedBox(height: 20),
                    DifferenceSection(),
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

class CheckList extends StatelessWidget {
  const CheckList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SubscriptionController.instance;
    return Obx(() => !controller.subscriptionLoading.value
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: controller.subscription.value.description.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              Icon(CupertinoIcons.check_mark, color: Colors.white),
              SizedBox(width: 10),
              Text(
                item,
                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                //softWrap: true,
              ),
            ],
          ),
        );
      }).toList(),
    )
        : CircularProgressIndicator()
    );
  }
}

class PriceSection extends StatefulWidget {
  const PriceSection({super.key});

  @override
  _PriceSectionState createState() => _PriceSectionState();
}

class _PriceSectionState extends State<PriceSection> {
  String selectedPlan = '';

  @override
  Widget build(BuildContext context) {
    final controller = SubscriptionController.instance;
    return Obx(() => !controller.subscriptionLoading.value
      ? Column(
          children: controller.subscription.value.price.entries.map((entry) {
            final label = entry.key;
            final price = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: PriceCard(
                label: "$label /",
                price: price,
                isSelected: selectedPlan == label,
                onTap: () {
                  setState(() {
                    selectedPlan = label;
                  });
                },
              ),
            );
          }).toList(),
        )
        : CircularProgressIndicator()
    );
  }
}

class PriceCard extends StatelessWidget {
  const PriceCard({super.key, required this.label, required this.price, required this.isSelected, required this.onTap});

  final String label;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.7),
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              price,
              style: TextStyle(fontSize: 36, color: Colors.white),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class CallToAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: TColors.primary,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: () {},
      child: Column(
        children: [
          Text(
            'GET IT NOW !',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            'over 93.2% of users chose this plan',
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class DifferenceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Care este diferenta dintre ANUAL si LUNAR?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[500]),
        ),
        SizedBox(height: 10),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at facilisis neque. Nulla varius massa a libero tempor, nec ultricies nulla viverra.',
          style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
        ),
      ],
    );
  }
}