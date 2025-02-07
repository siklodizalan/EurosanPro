import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../data/repositories/offerings/offerings_repository.dart';

class OfferingsController extends GetxController {
  static OfferingsController get instance => Get.find();

  RxList<Offering> offerings = <Offering>[].obs;
  final offeringsRepository = OfferingsRepository();

  @override
  void onInit() {
    super.onInit();
    fetchOfferings();
  }

  Future<void> fetchOfferings() async {
    try {
      final fetchedOfferings = await offeringsRepository.fetchOfferings();
      offerings.value = fetchedOfferings;
    } catch (e) {
      print('Failed to fetch offerings: $e');
    }
  }
}
