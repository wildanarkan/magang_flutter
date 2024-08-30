import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/business_trip_controller.dart';

class BusinessTripDetailPageController extends GetxController {
  var selectedCompany = ''.obs;
  var selectedCity = ''.obs;

  var companyItem = <String>[].obs;
  var cityItem = <String>[].obs;
  List<dynamic> _apiData = []; // Untuk menyimpan seluruh data dari API

  var isCityEnabled = false.obs;
  var extendedController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;
  var endDateController = TextEditingController().obs;

  void fetchCompanyItems() async {
    try {
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse(URLs.company), // Ganti dengan URL API Anda
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _apiData = json.decode(response.body);
        companyItem.value =
            _apiData.map((item) => item['name'].toString()).toList();

        // Set default selected company and limit
        if (companyItem.isNotEmpty) {
          selectedCompany.value = companyItem[0];
        }
      } else {
        // Handle error response
        Get.snackbar('Error', 'Failed to load company items');
      }
    } catch (e) {
      // Handle network error
      Get.snackbar('Error', 'Failed to load company items');
    }
  }

  Future<void> updateExtendedDay(int businessTripId, int extendDay) async {
    try {
      final token = GetStorage().read('accessToken');
      final url = Uri.parse('${URLs.updateExtendedDay}$businessTripId');
      print('URL: $url');

      final response = await http.put(
        url, // Ganti dengan URL API yang sesuai
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'extend_day': extendDay,
        }),
      );

      if (response.statusCode == 200) {
        final businessTripController = Get.find<BusinessTripController>();
        Get.back();
        businessTripController.fetchBusinessTrips();
        Get.snackbar('Success', 'extend updated to $extendDay');
      } else {
        Get.snackbar(
            'Error', 'Failed to update extend: ${response.statusCode}');
      }
      log(response.statusCode.toString());
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize companyItem and cityItem with data from API or other source
    // Example:
    // companyItem.value = ["Company 1", "Company 2", "Company 3"];
    fetchCompanyItems();
    cityItem.value = ["City 1", "City 2", "City 3"];
  }
}
