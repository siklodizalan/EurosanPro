import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eurosanpro/features/subscriptions/models/subscription_model.dart';
import 'package:eurosanpro/utils/exceptions/firebase_exceptions.dart';
import 'package:eurosanpro/utils/exceptions/format_exceptions.dart';
import 'package:eurosanpro/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SubscriptionRepository extends GetxController {
  static SubscriptionRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<SubscriptionModel> fetchSubscription() async {
    try {
      final documentSnapshot = await _db
          .collection("Subscriptions")
          .get();
      return documentSnapshot.docs.map((doc) => SubscriptionModel.fromSnapshot(doc)).toList()[0];
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}