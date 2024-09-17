import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/repo/leave_history_repository.dart';

class LeaveAddPageController extends GetxController {
  final LeaveHistoryRepository _leaveHistoryRepository =
      LeaveHistoryRepository();

  RxList<String> leaveCategoryItem = <String>[].obs;
  RxString selectedCategory = ''.obs;
  RxString selectedLimit = ''.obs;

  final reasonForLeaveController = TextEditingController().obs;
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;

  List<dynamic> _apiData = [];

  @override
  void onInit() {
    super.onInit();
    fetchCategoryItems();
  }

  void fetchCategoryItems() async {
    _apiData = (await _leaveHistoryRepository.fetchCategoryItems())!;
    leaveCategoryItem.value =
        _apiData.map((item) => item['name'].toString()).toList();
    if (leaveCategoryItem.isNotEmpty) {
      selectedCategory.value = leaveCategoryItem[0];
      updateSelectedLimit(selectedCategory.value);
    }
    }

  void updateSelectedLimit(String categoryName) {
    final limit = _apiData
        .firstWhere((item) => item['name'] == categoryName)['limit']
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
              .firstWhere(
                  (item) => item['name'] == selectedCategory.value)['id']
              .toString(),
          'reason_for_leave': reasonForLeaveController.value.text,
          'start_date': startDateController.value.text,
          'end_date': endDateController.value.text,
        }),
      );

      if (response.statusCode == 201) {
        Get.back(closeOverlays: true);
        Get.snackbar('Success', 'Leave request successfully created');
      } else {
        Get.snackbar('Error',
            'Failed to create leave, try adding data that has not been filled in');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
