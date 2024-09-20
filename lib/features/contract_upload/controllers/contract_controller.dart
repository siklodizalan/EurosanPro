import 'dart:io';

import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/data/repositories/contract/contract_repository.dart';
import 'package:eurosanpro/data/repositories/user/user_repository.dart';
import 'package:eurosanpro/features/authentication/models/user_model.dart';
import 'package:eurosanpro/features/contract_upload/models/contract_model.dart';
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

  Future<void> extractTextFromPdf(PdfDocument document, String url) async {
    try {
      String content = PdfTextExtractor(document).extractText();
      document.dispose();

      String cleanedText = cleanText(content);

      await updateUserDetails(cleanedText);
      await saveContractRecord(cleanedText, url);

      TLoaders.successSnackBar(title: 'Congratulations!', message: 'Your contract has been uploaded!');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> updateUserDetails(String extractedText) async {
    print(extractedText);
    RegExp nameRegex = RegExp(r'(?<=Persoană fizică\s)[\w\s]+');
    RegExp cnpRegex = RegExp(r'(?<=CNP:)\d{13}');
    RegExp cityRegex = RegExp(r'(?<=domiciliat / domicialiată ăn\s)[\w\s]+');
    RegExp countryRegex = RegExp(r'(?<=judecul\s)[\w\s]+');
    RegExp addressRegex = RegExp(r'(?<=adresa:\s)[\w\s]+');
    RegExp phoneRegex = RegExp(r'(?<=numarul detelefon\s)\d{4} \d{3} \d{3}');
    RegExp emailRegex = RegExp(r'(?<=adresa de email:\s)[\w.]+@[\w.]+');

    String? name = nameRegex.firstMatch(extractedText)?.group(0);
    String? cnp = cnpRegex.firstMatch(extractedText)?.group(0);
    String? city = cityRegex.firstMatch(extractedText)?.group(0);
    List<RegExpMatch> countryMatches = countryRegex.allMatches(extractedText).toList();
    String? country = countryMatches.length >= 3 ? countryMatches[2].group(0) : null;
    String? address = addressRegex.firstMatch(extractedText)?.group(0);
    String? phone = phoneRegex.firstMatch(extractedText)?.group(0);
    String? contractEmail = emailRegex.firstMatch(extractedText)?.group(0);

    final currentUser = AuthenticationRepository.instance.authUser;

    UserModel updatedUser = UserModel(
        id: currentUser!.uid,
        name: name!,
        cnp: cnp!,
        city: city!,
        country: country!,
        address: address!,
        phoneNumber: phone!,
        loginEmail: currentUser.email!,
        contractEmail: contractEmail!
    );

    await userRepository.updateUserDetails(updatedUser);
  }

  Future<void> saveContractRecord(String extractedText, String url) async {
    final contractNumberRegex = RegExp(r'Nr\.\s*(\d+)');
    final contractDateRegex = RegExp(r'Data\s*([\d\-]+)');
    final productNameRegex = RegExp(r'5\. PRODUSELE CONTRACTATE:1\.\s*(.*?)\s*standard', dotAll: true);
    final productSizeRegex = RegExp(r'(\d+mm\s*x\s*\d+mm)');
    final panelTypeRegex = RegExp(r'panouri\s*(\w+)');
    final panelColourRegex = RegExp(r'dungi\s+([^\(]+?\s*\([^\)]*\))');

    String contractNumber = contractNumberRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';
    String contractDate = contractDateRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';
    contractDate = contractDate.substring(0, contractDate.length - 1);
    String productName = productNameRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';
    String productSize = productSizeRegex.firstMatch(extractedText)?.group(0) ?? 'Not found';
    String panelType = panelTypeRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';
    String panelColour = panelColourRegex.firstMatch(extractedText)?.group(1) ?? 'Not found';

    if (productName == 'Uăă secăională rezidenăială') {
      productName = 'Ușă secțională rezidențială';
    }

    final currentUser = AuthenticationRepository.instance.authUser;

    ContractModel contract = ContractModel(
      userId: currentUser!.uid,
      contractNumber: contractNumber,
      contractDate: contractDate,
      productName: productName,
      productSize: productSize,
      panelType: panelType,
      panelColour: panelColour,
      contractUrl: url
    );

    await contractRepository.addContractRecord(contract);
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