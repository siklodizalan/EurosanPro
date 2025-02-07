import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  String phoneNumber;
  final String loginEmail;
  final String subscriptionId;
  String role;
  bool allowNotifications;
  List<String> deviceTokens;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.loginEmail,
    required this.subscriptionId,
    this.role = 'USER',
    this.allowNotifications = false,
    this.deviceTokens = const [],
  });

  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        loginEmail: '',
        subscriptionId: '',
        role: 'USER',
        allowNotifications: false,
        deviceTokens: [],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'LoginEmail': loginEmail,
      'SubscriptionId': subscriptionId,
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
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        loginEmail: data['LoginEmail'] ?? '',
        subscriptionId: data['SubscriptionId'] ?? '',
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
