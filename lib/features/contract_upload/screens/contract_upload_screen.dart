import 'dart:io';
import 'dart:typed_data';

import 'package:eurosanpro/common/widgets/custom_header.dart';
import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/features/contract_upload/controllers/contract_controller.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:eurosanpro/utils/constraints/text_strings.dart';
import 'package:eurosanpro/utils/helpers/helper_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ContractUploadScreen extends StatefulWidget {
  const ContractUploadScreen({
    super.key,
  });

  @override
  State<ContractUploadScreen> createState() => _ContractUploadScreenState();
}

class _ContractUploadScreenState extends State<ContractUploadScreen> {
  String? _fileName;
  RxBool loading = false.obs;
  final contractController = ContractController.instance;

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: THelperFunctions.screenHeight(context) / 8),
          const TCustomHeader(text: TTexts.beforeYouStart),
          const SizedBox(height: TSizes.spaceBtwSections / 2),
          GestureDetector(
            onTap: _pickPdf,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey[200]
              ),
              child: Center(
                child: _fileName == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.picture_as_pdf, size: 60, color: Colors.grey[700]),
                    const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                    Text(
                      'Tap to upload PDF',
                      style: TextStyle(fontSize: 18, color: Colors.grey[700], decoration: TextDecoration.none),
                    )
                  ],
                )
                    : Text(
                    'Selected:\n$_fileName',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700], decoration: TextDecoration.none)
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Obx(() =>
            loading.value ? const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: TSizes.spaceBtwInputFields)
                ]
            ) : const SizedBox()
          ),
          SizedBox(
            width: TSizes.buttonWidth,
            child: ElevatedButton(
                onPressed: () {
                  AuthenticationRepository.instance.screenRedirect();
                },
                child: const Text(TTexts.saveMyData)
            ),
          ),
        ],
      ),
    );
  }
}
