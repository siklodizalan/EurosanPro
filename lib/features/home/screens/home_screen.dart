import 'package:eurosanpro/common/widgets/appbar/side_by_side_images.dart';
import 'package:eurosanpro/common/widgets/shapes/curved_edges_widget.dart';
import 'package:eurosanpro/common/widgets/title_description.dart';
import 'package:eurosanpro/features/authentication/controllers/user_controller.dart';
import 'package:eurosanpro/features/contract_upload/controllers/contract_controller.dart';
import 'package:eurosanpro/features/home/screens/widgets/home_screen_middle_part.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contractController = ContractController.instance;
    final userController = UserController.instance;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(TImages.backgroundImageFaded),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Top image section
                    const SideBySideImages(),
                  ],
                ),
              ),
            ),

            Obx(() => !userController.profileLoading.value && !contractController.contractLoading.value
                ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: HomeScreenMiddlePart(),
            )
                : const Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            )),

            TCurvedEdgeWidget(
              child: Container(
                color: Colors.grey[900],
                padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
                child: Obx(() => !userController.profileLoading.value &&
                    !contractController.contractLoading.value
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        contractController.contract.value.productName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: TSizes.lg,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: TSizes.md),
                    TitleAndDescription(
                        title: 'marime',
                        description: contractController
                            .contract.value.productSize),
                    TitleAndDescription(
                        title: 'panouri',
                        description: contractController
                            .contract.value.panelType),
                    TitleAndDescription(
                        title: 'dungi late',
                        description: contractController
                            .contract.value.panelColour),
                    const SizedBox(height: TSizes.md),
                  ],
                )
                    : const CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
