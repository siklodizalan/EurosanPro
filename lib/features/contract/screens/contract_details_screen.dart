import 'package:eurosanpro/features/contract/controllers/contract_controller.dart';
import 'package:eurosanpro/features/contract/models/contract_model.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/logo.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eurosanpro/common/widgets/appbar/side_by_side_images.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';

class ContractDetailsScreen extends StatelessWidget {
  const ContractDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contractController = ContractController.instance;

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
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const Logo(imagePath: TImages.eurosanProLogo),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (contractController.contractLoading.value) {
                        return const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        );
                      }

                      final contract = contractController.contract.value;

                      return _ContractDataDisplay(contract: contract);
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

class _ContractDataDisplay extends StatelessWidget {
  final ContractModel? contract;

  const _ContractDataDisplay({required this.contract});

  @override
  Widget build(BuildContext context) {
    return contract == null
        ? const Text("No contract data available", style: TextStyle(color: Colors.white))
        : Column(
            children: [
              Text(
                "Contract Details for ${contract!.nameInContract}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: TSizes.fontSizeLg,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.primary, width: 1),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.6),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDataRow("Address", contract!.address),
                    _buildDataRow("CNP", contract!.cnp),
                    _buildDataRow("City", contract!.city),
                    _buildDataRow("Contract Date", contract!.contractDate),
                    _buildDataRow("Email", contract!.contractEmail),
                    _buildDataRow("Contract Number", contract!.contractNumber),
                    _buildDataRow("Country", contract!.country),
                    _buildDataRow("Panel Colour", contract!.panelColour),
                    _buildDataRow("Panel Type", contract!.panelType),
                    _buildDataRow("Phone", contract!.phoneInContract),
                    _buildDataRow("Product Name", contract!.productName),
                    _buildDataRow("Product Size", contract!.productSize),
                  ],
                ),
              ), 
            ],
          );
  }

  Widget _buildDataRow(String label, String value) {
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
