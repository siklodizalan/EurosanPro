import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eurosanpro/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String name;
  String cnp;
  String city;
  String country;
  String address;
  String phoneNumber;
  final String loginEmail;
  final String contractEmail;
  String role;
  bool allowNotifications;
  List<String> deviceTokens;

  UserModel({
    required this.id,
    required this.name,
    required this.cnp,
    required this.city,
    required this.country,
    required this.address,
    required this.phoneNumber,
    required this.loginEmail,
    required this.contractEmail,
    this.role = 'USER',
    this.allowNotifications = false,
    this.deviceTokens = const [],
  });

  static UserModel empty() => UserModel(
    id: '',
    name: '',
    cnp: '',
    city: '',
    country: '',
    address: '',
    phoneNumber: '',
    loginEmail: '',
    contractEmail: '',
    role: 'USER',
    allowNotifications: false,
    deviceTokens: [],
  );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'CNP': cnp,
      'City': city,
      'County': country,
      'address': address,
      'PhoneNumber': phoneNumber,
      'LoginEmail': loginEmail,
      'ContractEmail': contractEmail,
      'Role': role,
      'AllowNotifications': allowNotifications,
      'DeviceTokens': deviceTokens,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return UserModel(
        id: document.id,
        name: data['Name'] ?? '',
        cnp: data['CNP'] ?? '',
        city: data['City'] ?? '',
        country: data['Country'] ?? '',
        address: data['address'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        loginEmail: data['LoginEmail'] ?? '',
        contractEmail: data['ContractEmail'] ?? '',
        role: data['Role'] ?? 'USER',
        allowNotifications: data['AllowNotifications'] ?? false,
        deviceTokens: data['DeviceTokens'] != null
            ? List<String>.from(data['DeviceTokens'])
            : [],
      );
    } else {
      return UserModel.empty();
    }
  }
}
