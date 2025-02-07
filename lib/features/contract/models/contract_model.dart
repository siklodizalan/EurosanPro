import 'package:cloud_firestore/cloud_firestore.dart';

class ContractModel {
  String id;
  String userId;
  String contractNumber;
  String contractDate;
  String productName;
  String productSize;
  String panelType;
  String panelColour;
  String contractUrl;
  String nameInContract;
  String cnp;
  String city;
  String country;
  String address;
  String phoneInContract;
  String contractEmail;

  ContractModel({
    required this.id,
    required this.userId,
    required this.contractNumber,
    required this.contractDate,
    required this.productName,
    required this.productSize,
    required this.panelType,
    required this.panelColour,
    required this.contractUrl,
    required this.nameInContract,
    required this.cnp,
    required this.city,
    required this.country,
    required this.address,
    required this.phoneInContract,
    required this.contractEmail
  });

  static ContractModel empty() => ContractModel(
    id: '',
    userId: '',
    contractNumber: '',
    contractDate: '',
    productName: '',
    productSize: '',
    panelType: '',
    panelColour: '',
    contractUrl: '',
    nameInContract: '',
    cnp: '',
    city: '',
    country: '',
    address: '',
    phoneInContract: '',
    contractEmail: ''
  );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'ContractNumber': contractNumber,
      'ContractDate': contractDate,
      'ProductName': productName,
      'ProductSize': productSize,
      'PanelType': panelType,
      'PanelColour': panelColour,
      'ContractUrl': contractUrl,
      'NameInContract': nameInContract,
      'CNP': cnp,
      'City': city,
      'Country': country,
      'Address': address,
      'PhoneInContract': phoneInContract,
      'ContractEmail': contractEmail,
    };
  }

  factory ContractModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return ContractModel(
        id: data['Id'] ?? '',
        userId: data['UserId'] ?? '',
        contractNumber: data['ContractNumber'] ?? '',
        contractDate: data['ContractDate'] ?? '',
        productName: data['ProductName'] ?? '',
        productSize: data['ProductSize'] ?? '',
        panelType: data['PanelType'] ?? '',
        panelColour: data['PanelColour'] ?? '',
        contractUrl: data['ContractUrl'] ?? '',
        nameInContract: data['NameInContract'] ?? '',
        cnp: data['CNP'] ?? '',
        city: data['City'] ?? '',
        country: data['Country'] ?? '',
        address: data['Address'] ?? '',
        phoneInContract: data['PhoneInContract'] ?? '',
        contractEmail: data['ContractEmail'] ?? '',
      );
    } else {
      return ContractModel.empty();
    }
  }
}
