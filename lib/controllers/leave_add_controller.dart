import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/data/repo/leave_history_repository.dart';

class LeaveAddController extends GetxController {
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
    bool isSuccess = await _leaveHistoryRepository.postLeave(
      selectedCategory: selectedCategory.value,
      reasonForLeave: reasonForLeaveController.value.text,
      startDate: startDateController.value.text,
      endDate: endDateController.value.text,
      apiData: _apiData
          .firstWhere((item) => item['name'] == selectedCategory.value)['id']
          .toString(),
    );

    if (isSuccess) {
      Get.back(closeOverlays: true);
      Get.snackbar('Success', 'Leave request successfully created');
    } else {
      Get.snackbar('Failed',
          'Masukkan semua data dengan benar');
    }
  }
}
