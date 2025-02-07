import 'dart:io';
import 'dart:typed_data';

import 'package:eurosanpro/common/widgets/appbar/side_by_side_images.dart';
import 'package:eurosanpro/features/contract/controllers/contract_controller.dart';
import 'package:eurosanpro/features/contract/screens/contract_details_screen.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/call_to_action.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/logo.dart';
import 'package:eurosanpro/navigation_menu.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ContractUploadScreen extends StatefulWidget {
  const ContractUploadScreen({super.key});

  @override
  State<ContractUploadScreen> createState() => _ContractUploadScreenState();
}

class _ContractUploadScreenState extends State<ContractUploadScreen> {
  String? _fileName;
  RxBool loading = false.obs;
  final contractController = ContractController.instance;

  @override
  void initState() {
    super.initState();
    _checkExistingContract();
  }

  void _checkExistingContract() {
    if (contractController.contract.value.id.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.off(() => const ContractDetailsScreen());
      });
    }
  }

  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true
    );

    setState(() {
      loading.value = true;
    });

    if (result != null && result.files.single.path != null) {
      String url = await contractController.uploadContractRecord(
          PlatformFile(path: result.files.single.path, name: result.files.single.name, size: result.files.single.size)
      );
      setState(() {
        _fileName = result.files.single.name;
      });

      Uint8List? bytes = result.files.single.bytes;
      bytes = await File(result.files.single.path!).readAsBytes();

      final PdfDocument document = PdfDocument(inputBytes: bytes);

      await contractController.extractTextFromPdf(document, url);

      setState(() {
        loading.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Top image section
                    const SideBySideImages(),
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        children: [
                          const Logo(imagePath: TImages.eurosanProLogo),
                          Text(
                            TTexts.beforeYouStart,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TColors.primary, fontWeight: FontWeight.w600)
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //const SideBySideImages(),
            // Header section
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //SizedBox(height: THelperFunctions.screenHeight(context) / 8),
                  
                
                  // File picker
                  GestureDetector(
                    onTap: _pickPdf,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[600]!),
                        color: Colors.grey[850],
                      ),
                      child: Center(
                        child: _fileName == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.picture_as_pdf, size: 60, color: Colors.grey[400]),
                                  const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                                  Text(
                                    'Tap to upload PDF',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[400],
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Selected:\n$_fileName',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[400],
                                  decoration: TextDecoration.none,
                                ),
                              ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwInputFields * 2),

                  // Loading indicator
                  Obx(() =>
                    loading.value
                        ? const Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: TSizes.spaceBtwInputFields),
                            ],
                          )
                        : const SizedBox(),
                  ),

                  // Save button
                  CallToActionButton(
                    buttonText: TTexts.saveMyData,
                    fontSize: TSizes.fontSizeXl,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    textColor: Colors.white,
                    backgroundColor: TColors.primary,
                    onPressed: () async {
                      await contractController.fetchContractRecord();
                      Get.find<NavigationController>().reloadNavigation();
                    },
                    enabled: !loading.value,
                  ),
                  const SizedBox(height: TSizes.defaultSpace)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
