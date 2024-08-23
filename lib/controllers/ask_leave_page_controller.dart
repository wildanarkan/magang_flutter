import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';

class AskLeavePageController extends GetxController {
  RxList<String> companyItem = <String>[].obs;
  RxString selectedCompany = ''.obs;
  RxString selectedLimit = ''.obs;

  final reasonForLeaveController = TextEditingController().obs;
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;

  List<dynamic> _apiData = []; // Untuk menyimpan seluruh data dari API

  @override
  void onInit() {
    super.onInit();
    fetchCompanyItems();
  }

  void fetchCompanyItems() async {
    try {
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse(URLs.leaveCategory), // Ganti dengan URL API Anda
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
          updateSelectedLimit(selectedCompany.value);
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

  void updateSelectedLimit(String companyName) {
    final limit = _apiData
        .firstWhere((item) => item['name'] == companyName)['limit']
        .toString();
    selectedLimit.value = limit;
  }

   Future<void> makeLeave() async {
    try {
      final token = GetStorage().read('accessToken');
      final response = await http.post(
        Uri.parse(URLs.leaveStore),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'id_leave_category': _apiData
              .firstWhere((item) => item['name'] == selectedCompany.value)['id']
              .toString(),
          'reason_for_leave': reasonForLeaveController.value.text,
          'start_date': startDateController.value.text,
          'end_date': endDateController.value.text,
        }),
      );

      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar('Success', 'Leave request successfully created');
      } else {
        Get.snackbar('Error', 'Failed to create leave: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
