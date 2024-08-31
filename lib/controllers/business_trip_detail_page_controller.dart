import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/business_trip_controller.dart';

class BusinessTripDetailPageController extends GetxController {
  var isCityEnabled = false.obs;
  var extendedController = TextEditingController().obs;
  var extendDay = 0.obs;
  bool isChangeExtend = false;

  // Panggil ini saat halaman dimuat untuk menginisialisasi nilai extendDay
  void setInitialExtendDay(int day) {
    extendDay.value = day;
    log(extendDay.value.toString());
  }

  Future<void> updateExtendedDay(int businessTripId, int newExtendDay) async {
    try {
      final token = GetStorage().read('accessToken');
      final url = Uri.parse('${URLs.updateExtendedDay}$businessTripId');
      print('URL: $url');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'extend_day': newExtendDay,
        }),
      );

      if (response.statusCode == 200) {
        extendDay.value = newExtendDay; // Update nilai extendDay di controller
        isChangeExtend = true; // Perbaikan di sini
        Get.back();
        Get.snackbar('Success', 'Extend updated to $newExtendDay');
      } else {
        Get.snackbar('Error', 'Failed to update extend: ${response.statusCode}');
      }
      log(response.statusCode.toString());
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  void onClose() {
    if (isChangeExtend) {
      final BusinessTripController businessTripController =
          Get.find<BusinessTripController>();
      businessTripController.fetchBusinessTrips();
      log(isChangeExtend.toString());
      isChangeExtend = false; // Reset isChangeExtend setelah fetching
    }
    log(isChangeExtend.toString());

    super.onClose();
  }
}
