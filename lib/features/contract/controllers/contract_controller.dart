import 'dart:io';

import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/data/repositories/contract/contract_repository.dart';
import 'package:eurosanpro/data/repositories/user/user_repository.dart';
import 'package:eurosanpro/features/contract/models/contract_model.dart';
import 'package:eurosanpro/utils/popups/loaders.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ContractController extends GetxController {
  static ContractController get instance => Get.find();

  final userRepository = UserRepository.instance;
  final contractLoading = false.obs;
  Rx<ContractModel> contract = ContractModel.empty().obs;
  final contractRepository = Get.put(ContractRepository());

  @override
  void onInit() {
    super.onInit();
    fetchContractRecord();
  }

  Future<void> fetchContractRecord() async {
    try {
      contractLoading.value = true;
      this.contract(ContractModel.empty());
      final contract = await contractRepository.fetchContractDetails();
      this.contract(contract);
    } catch (e) {
      contract(ContractModel.empty());
    } finally {
      contractLoading.value = false;
    }
  }

  Future<String> uploadContractRecord(PlatformFile contract) async {
    try {
      return await contractRepository.uploadContract('Users/Contracts/', contract.name, File(contract.path!));
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<bool> extractTextFromPdf(PdfDocument document, String url) async {
    try {
      String content = PdfTextExtractor(document).extractText();
      document.dispose();

      String cleanedText = cleanText(content);

      final eligible = await saveContractRecord(cleanedText, url);

      TLoaders.successSnackBar(title: 'Congratulations!', message: 'Your contract has been uploaded!');
      return eligible;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return false;
    }
  }

  Future<bool> saveContractRecord(String extractedText, String url) async {
    RegExp contractNumberRegex = RegExp(r'Nr\.\s*(\d+)');
    RegExp contractDateRegex = RegExp(r'Data\s*([\d\-]+)');
    RegExp productNameRegex = RegExp(r'5\. PRODUSELE CONTRACTATE:1\.\s*(.*?)\s*standard', dotAll: true);
    RegExp productSizeRegex = RegExp(r'(\d+mm\s*x\s*\d+mm)');
    RegExp panelTypeRegex = RegExp(r'panouri\s*(\w+)');
    RegExp panelColourRegex = RegExp(r'dungi\s+([^\(]+?\s*\([^\)]*\))');
    RegExp nameRegex = RegExp(r'(?<=Persoană fizică\s)[\w\s]+');
    RegExp cnpRegex = RegExp(r'(?<=CNP:)\d{13}');
    RegExp cityRegex = RegExp(r'(?<=domiciliat / domicialiată ăn\s)[\w\s]+');
    RegExp countryRegex = RegExp(r'(?<=judecul\s)[\w\s]+');
    RegExp addressRegex = RegExp(r'(?<=adresa:\s)[\w\s]+');
    RegExp phoneRegex = RegExp(r'(?<=numarul detelefon\s)\d{4} \d{3} \d{3}');
    RegExp emailRegex = RegExp(r'(?<=adresa de email:\s)[\w.]+@[\w.]+');

    String contractNumber = contractNumberRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';
    String contractDate = contractDateRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';
    contractDate = contractDate.substring(0, contractDate.length - 1);
    String productName = productNameRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';
    String productSize = productSizeRegex.firstMatch(extractedText)?.group(0) ?? 'Not found';
    String panelType = panelTypeRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';
    String panelColour = panelColourRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';
    String nameInContract = nameRegex.firstMatch(extractedText)?.group(0) ?? 'Not found';
    String cnp = cnpRegex.firstMatch(extractedText)?.group(0) ?? 'Not found';
    String city = cityRegex.firstMatch(extractedText)?.group(0) ?? 'Not found';
    List<RegExpMatch> countryMatches = countryRegex.allMatches(extractedText).toList();
    String country = countryMatches.length >= 3 && countryMatches[2].group(0) != null 
      ? countryMatches[2].group(0)! 
      : 'Not found';
    String address = addressRegex.firstMatch(extractedText)?.group(0) ?? 'Not found';
    String phoneInContract = phoneRegex.firstMatch(extractedText)?.group(0) ?? 'Not found';
    String contractEmail = emailRegex.firstMatch(extractedText)?.group(0) ?? 'Not found';

    if (productName == 'Uăă secăională rezidenăială') {
      productName = 'Ușă secțională rezidențială';
    }

    final currentUser = AuthenticationRepository.instance.authUser;

    ContractModel contract = ContractModel(
      id: '',
      userId: currentUser!.uid,
      contractNumber: contractNumber,
      contractDate: contractDate,
      productName: productName,
      productSize: productSize,
      panelType: panelType,
      panelColour: panelColour,
      contractUrl: url,
      nameInContract: nameInContract,
      cnp: cnp,
      city: city,
      country: country,
      address: address,
      phoneInContract: phoneInContract,
      contractEmail: contractEmail
    );

    String contractId = await contractRepository.addContractRecord(contract);
    contract.id = contractId;
    await contractRepository.updateContractWithId(contract);
    await userRepository.addUserContractId(currentUser.uid, contractId);

    return productName != 'Not found';
  }

  String cleanText(String text) {
    StringBuffer result = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i % 2 == 1 && text[i] != '\n') {
        if (text[i] == '_') {
          result.write('ș');
        }
        else if (text.codeUnitAt(i) < 0x20 || text.codeUnitAt(i) > 0x7E) {
          result.write('ă');
        } else {
          result.write(text[i]);
        }
      }
    }

    return result.toString();
  }
}