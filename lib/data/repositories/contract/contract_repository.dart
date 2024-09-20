import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/features/contract_upload/models/contract_model.dart';
import 'package:eurosanpro/utils/exceptions/firebase_exceptions.dart';
import 'package:eurosanpro/utils/exceptions/format_exceptions.dart';
import 'package:eurosanpro/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ContractRepository extends GetxController {
  static ContractRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addContractRecord(ContractModel contract) async {
    try {
      await _db.collection("Contracts").add(contract.toJson());
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

  Future<ContractModel> fetchContractDetails() async {
    try {
      final result = await _db
          .collection("Contracts")
          .where('UserId', isEqualTo: AuthenticationRepository.instance.authUser?.uid)
          .get();
      return result.docs
          .map(
              (documentSnapshot) => ContractModel.fromSnapshot(documentSnapshot))
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

  Future<String> uploadContract(String path, String name, File contract) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(name);
      await ref.putFile(File(contract.path));
      final url = await ref.getDownloadURL();
      return url;
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