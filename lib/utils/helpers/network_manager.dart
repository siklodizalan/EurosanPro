import 'dart:async';
import 'package:eurosanpro/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((results) {
      _updateConnectionStatus(results);
    });
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    ConnectivityResult result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    _connectionStatus.value = result;

    if (_connectionStatus.value == ConnectivityResult.none) {
      TLoaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  Future<bool> isConnected() async {
    try {
      List<ConnectivityResult> results = await _connectivity.checkConnectivity();
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
