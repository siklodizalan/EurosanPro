import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/features/subscriptions/models/subscription_model.dart';
import 'package:eurosanpro/utils/constraints/api_constraints.dart';
import 'package:eurosanpro/utils/exceptions/firebase_exceptions.dart';
import 'package:eurosanpro/utils/exceptions/format_exceptions.dart';
import 'package:eurosanpro/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionRepository extends GetxController {
  static SubscriptionRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future init() async {
    await Purchases.setLogLevel(LogLevel.debug);
    final configuration = PurchasesConfiguration(APIConstants.revenueCatApiKey);
    await Purchases.configure(configuration);
  }

  Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      return current == null ? [] : [current];
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> saveSubscription(SubscriptionModel subscription) async {
    try {
      final subscriptionRef = _db.collection('Subscriptions').doc();
      final subscriptionId = subscriptionRef.id;

      final updatedSubscription = subscription.copyWith(id: subscriptionId);

      await subscriptionRef.set(updatedSubscription.toJson());

      final userRef = _db.collection('Users').doc(subscription.userId);
      await userRef.update({
        'subscriptionId': subscriptionId,
      });
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

  Future<SubscriptionModel> fetchSubscriptionDetails() async {
    try {
      final result = await _db
          .collection("Subscriptions")
          .where('UserId',
              isEqualTo: AuthenticationRepository.instance.authUser?.uid)
          .get();
      return result.docs
          .map((documentSnapshot) =>
              SubscriptionModel.fromSnapshot(documentSnapshot))
          .toList()[0];
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

  Future<SubscriptionModel?> fetchSubscriptionById(String subscriptionId) async {
    try {
      final docSnapshot = await _db.collection('Subscriptions').doc(subscriptionId).get();
      if (docSnapshot.exists) {
        return SubscriptionModel.fromSnapshot(docSnapshot);
      }
      return null;
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