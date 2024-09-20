import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionModel {
  final String id;
  List<String> description;
  Map<String, String> price;

  SubscriptionModel({
    required this.id,
    required this.description,
    required this.price,
  });

  static SubscriptionModel empty() => SubscriptionModel(
    id: '',
    description: [],
    price: {},
  );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Description': description,
      'Price': price,
    };
  }

  factory SubscriptionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return SubscriptionModel(
        id: document.id,
        description: data['Description'] != null
            ? List<String>.from(data['Description'])
            : [],
        price: data['Price'] != null
            ? Map<String, String>.from(data['Price'])
            : {},
      );
    } else {
      return SubscriptionModel.empty();
    }
  }
}
