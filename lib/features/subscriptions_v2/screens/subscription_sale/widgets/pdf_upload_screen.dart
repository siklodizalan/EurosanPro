import 'dart:async';

import 'package:eurosanpro/features/contract/controllers/contract_controller.dart';
import 'package:eurosanpro/features/subscriptions/controllers/subscription_controller.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/call_to_action.dart';
import 'package:eurosanpro/features/subscriptions/screens/widgets/logo.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfUploadScreen extends StatefulWidget {
  const PdfUploadScreen({super.key});

  @override
  _PdfUploadScreenState createState() => _PdfUploadScreenState();
}

class _PdfUploadScreenState extends State<PdfUploadScreen> {
  String statusMessage = "";
  int _dotCount = 1; 
  late Timer _timer;
  IconData statusIcon = CupertinoIcons.nosign;
  Color statusColor = Colors.transparent;
  String? _fileName;
  RxBool loading = true.obs;
  String? packageIdentifier;
  final contractController = ContractController.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (packageIdentifier == null) {  // Only set this once
      final args = ModalRoute.of(context)!.settings.arguments as Map?;
      packageIdentifier = args?['packageIdentifier'] as String?;
    }
  }

  void _startDotAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        statusMessage = statusMessage.substring(0, statusMessage.length - _dotCount);
        _dotCount = (_dotCount % 3) + 1;
        statusMessage = statusMessage + ("." * _dotCount);
      });
    });
  }

  void _stopDotAnimation() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  Future<void> _pickPdf() async {
   final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true
    );
    
    setState(() {
      statusMessage = "Uploading contract.";
      statusIcon = CupertinoIcons.cloud_upload;
      statusColor = Colors.orange;
    });
    _startDotAnimation();

    try { 
      if (result != null && result.files.single.path != null) {
      String url = await contractController.uploadContractRecord(
          PlatformFile(path: result.files.single.path, name: result.files.single.name, size: result.files.single.size)
      );
      setState(() {
        _fileName = result.files.single.name;
        _dotCount = 1;
        statusMessage = "Checking contract.";
        statusIcon = CupertinoIcons.checkmark_circle;
        statusColor = Colors.blue;
      });

      Uint8List? bytes = result.files.single.bytes;
      bytes = await File(result.files.single.path!).readAsBytes();

      final PdfDocument document = PdfDocument(inputBytes: bytes);

      bool isEligible = await contractController.extractTextFromPdf(document, url);

      _stopDotAnimation();
      setState(() {
        statusMessage = isEligible ? "Contract eligible" : "Contract declined";
        statusColor = isEligible ? Colors.green : Colors.red;
        statusIcon = isEligible ? CupertinoIcons.hand_thumbsup : CupertinoIcons.hand_thumbsdown;
        loading.value = false;
      });
    }
      
    } catch (e) {
      _startDotAnimation();
      setState(() {
        statusMessage = "Error uploading contract";
        statusColor = Colors.red;
        statusIcon = CupertinoIcons.xmark;
        loading.value = false;
      });
    }
  }

  @override
  void dispose() {
    _stopDotAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionController = SubscriptionController.instance;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Orange fade-in on all sides (top, bottom, left, right)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    Colors.orange.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // "X" button at the top-right corner
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            icon: const Icon(
              CupertinoIcons.xmark,
              color: Colors.white70,
              size: 30,
            ),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ),

          // PDF picker in the center
          Center(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Logo(imagePath: TImages.eurosanProLogo),
                  const SizedBox(height: 50),
                  const Text(
                    "Please upload the contract you got with your product!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  // PDF picker button (smaller size)
                  GestureDetector(
                    onTap: _pickPdf,
                    child: Container(
                      width: double.infinity,
                      height: 100,
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
                                  Icon(Icons.picture_as_pdf, size: 40, color: Colors.grey[400]),
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
                  // Status label with icon at the bottom
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                          Icon(
                              statusIcon,
                              color: statusColor,
                              size: 30,
                          ),
                      const SizedBox(width: 10),
                      Text(
                        statusMessage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields * 2),
                  CallToActionButton(
                    buttonText: "Get the subscription",
                    fontSize: TSizes.fontSizeXl,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    textColor: Colors.white,
                    backgroundColor: TColors.primary,
                    onPressed: () async {
                      if (packageIdentifier != null) {
                        await subscriptionController.purchasePackage(packageIdentifier!);
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    },
                    enabled: !loading.value,
                  ),
                  const SizedBox(height: TSizes.defaultSpace)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
