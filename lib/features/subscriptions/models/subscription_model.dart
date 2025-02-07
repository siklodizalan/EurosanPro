import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionModel {
  final String id;
  final String userId;
  final String startDate;
  final String length;
  final String nextBillingDate;
  final double price;
  final String packageIdentifier;
  final String storeProductIdentifier;
  final String title;
  final String currencyCode;

  SubscriptionModel({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.length,
    required this.nextBillingDate,
    required this.price,
    required this.packageIdentifier,
    required this.storeProductIdentifier,
    required this.title,
    required this.currencyCode,
  });

  // Empty instance
  factory SubscriptionModel.empty() {
    return SubscriptionModel(
      id: '',
      userId: '',
      startDate: '',
      length: '',
      nextBillingDate: '',
      price: 0.0,
      packageIdentifier: '',
      storeProductIdentifier: '',
      title: '',
      currencyCode: '',
    );
  }

  SubscriptionModel copyWith({
    String? id,
    String? userId,
    String? startDate,
    String? length,
    String? nextBillingDate,
    double? price,
    String? packageIdentifier,
    String? storeProductIdentifier,
    String? title,
    String? currencyCode,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      length: length ?? this.length,
      nextBillingDate: nextBillingDate ?? this.nextBillingDate,
      price: price ?? this.price,
      packageIdentifier: packageIdentifier ?? this.packageIdentifier,
      storeProductIdentifier: storeProductIdentifier ?? this.storeProductIdentifier,
      title: title ?? this.title,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'StartDate': startDate,
      'Length': length,
      'NextBillingDate': nextBillingDate,
      'Price': price,
      'PackageIdentifier': packageIdentifier,
      'StoreProductIdentifier': storeProductIdentifier,
      'Title': title,
      'CurrencyCode': currencyCode,
    };
  }

  // Create instance from Firestore snapshot
  factory SubscriptionModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    
    return SubscriptionModel(
      id: document.id,
      userId: data['UserId'] ?? '',
      startDate: data['StartDate'] ?? '',
      length: data['Length'] ?? 0,
      nextBillingDate: data['NextBillingDate'] ?? '',
      price: (data['Price'] ?? 0).toDouble(),
      packageIdentifier: data['PackageIdentifier'] ?? '',
      storeProductIdentifier: data['StoreProductIdentifier'] ?? '',
      title: data['Title'] ?? '',
      currencyCode: data['CurrencyCode'] ?? '',
    );
  }
}
