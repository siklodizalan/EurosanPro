import 'package:cloud_firestore/cloud_firestore.dart';

class ContractModel {
  String userId;
  String contractNumber;
  String contractDate;
  String productName;
  String productSize;
  String panelType;
  String panelColour;
  String contractUrl;

  ContractModel({
    required this.userId,
    required this.contractNumber,
    required this.contractDate,
    required this.productName,
    required this.productSize,
    required this.panelType,
    required this.panelColour,
    required this.contractUrl,
  });

  static ContractModel empty() => ContractModel(
    userId: '',
    contractNumber: '',
    contractDate: '',
    productName: '',
    productSize: '',
    panelType: '',
    panelColour: '',
    contractUrl: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'ContractNumber': contractNumber,
      'ContractDate': contractDate,
      'ProductName': productName,
      'ProductSize': productSize,
      'PanelType': panelType,
      'PanelColour': panelColour,
      'ContractUrl': contractUrl,
    };
  }

  factory ContractModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return ContractModel(
        userId: data['UserId'] ?? '',
        contractNumber: data['ContractNumber'] ?? '',
        contractDate: data['ContractDate'] ?? '',
        productName: data['ProductName'] ?? '',
        productSize: data['ProductSize'] ?? '',
        panelType: data['PanelType'] ?? '',
        panelColour: data['PanelColour'] ?? '',
        contractUrl: data['ContractUrl'] ?? '',
      );
    } else {
      return ContractModel.empty();
    }
  }
}
