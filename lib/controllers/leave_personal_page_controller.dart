import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/data/models/leave_model.dart';
import 'package:magang_flutter/data/repo/leave_history_repository.dart';

extension DateTimeComparison on DateTime {
  bool isAtLeast(DateTime date) {
    return isAfter(date.subtract(const Duration(seconds: 1))) ||
        isAtSameMomentAs(date);
  }

  bool isAtMost(DateTime date) {
    return isBefore(date.add(const Duration(days: 1))) ||
        isAtSameMomentAs(date);
  }
}

class LeavePersonalPageController extends GetxController {
  final LeaveHistoryRepository _leaveHistoryRepository =
      Get.find<LeaveHistoryRepository>();

  var leaves = <Leaves>[].obs;
  var isLoading = true.obs;

  var filteredLeaveHistory = <Leaves>[].obs;
  var leaveHistory = <Leaves>[].obs;

  // Variable
  var selectedStatus = Rxn<String>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedStartDate = Rxn<DateTime>();

  // Text Editing Controller
  var endDateController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;

  var noData = false.obs;
  var pending = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchLeaves();
    resetFilter();
  }

  Future<void> fetchLeaves() async {
    try {
      isLoading(true);
      final leaves = await _leaveHistoryRepository.fetchByUserId();
      if (leaves.isNotEmpty) {
        leaveHistory.value = leaves;
        filterLeaves();
        noData.value = filteredLeaveHistory.isEmpty;
      } else {
        noData.value = true;
        leaveHistory.value = [];
      }
    } catch (e) {
      print('Error fetching leave history: $e');
      noData.value = true;
    } finally {
      isLoading(false);
    }
  }

  void filterLeaves() {
    final startDate = selectedStartDate.value;
    final endDate = selectedEndDate.value;

    filteredLeaveHistory.value = leaveHistory.where((leave) {
      final matchesStatus = selectedStatus.value == null ||
          selectedStatus.value == 'All' ||
          leave.status == selectedStatus.value;

      final leaveStartDate = DateTime.parse(leave.startDate ?? '');

      final matchesDateRange = (startDate == null && endDate == null) ||
          (startDate != null &&
              endDate != null &&
              leaveStartDate.isAtLeast(startDate) &&
              leaveStartDate.isAtMost(endDate));

      return matchesStatus && matchesDateRange;
    }).toList();

    noData.value = filteredLeaveHistory.isEmpty;
  }

  void resetFilter() {
    selectedStatus.value = 'All';
    selectedEndDate.value = null;
    selectedStartDate.value = null;
    startDateController.value.clear();
    endDateController.value.clear();
  }
}
