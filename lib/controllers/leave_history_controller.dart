import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/data/models/leave_model.dart';
import 'package:nextbasis_hris/data/repo/leave_history_repository.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

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

class LeaveHistoryController extends GetxController {
  // Repository
  final LeaveHistoryRepository _leaveHistoryRepository =
      Get.find<LeaveHistoryRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();

  var leaves = <Leaves>[].obs;
  var isLoading = true.obs;

  var filteredLeaveHistory = <Leaves>[].obs;
  var leaveHistory = <Leaves>[].obs;

  var userItems = <String>[].obs;

  var selectedNip = Rxn<int>();
  var selectedStatus = Rxn<String>();
  var selectedUser = Rxn<String>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedStartDate = Rxn<DateTime>();

  var endDateController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;

  var noData = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchUserItems();
    await fetchLeaves();
    resetFilter();
  }

  void filterByNip(int nip) {
    selectedNip.value = nip;
    filteredLeaveHistory.value =
        leaveHistory.where((leave) => leave.nip == nip).toList();
    noData.value = filteredLeaveHistory.isEmpty;
  }

  Future<void> fetchLeaves() async {
    try {
      isLoading(true);
      final leaves = await _leaveHistoryRepository.fetchAll();
      leaveHistory.value = leaves;

      if (selectedNip.value != null) {
        filteredLeaveHistory.value = leaveHistory
            .where((leave) => leave.nip == selectedNip.value)
            .toList();
      } else {
        filteredLeaveHistory.value = leaveHistory;
      }

      if (Get.arguments != null && Get.arguments['pendingPage'] == true) {
        filteredLeaveHistory.value =
            leaveHistory.where((leave) => leave.status == 'Pending').toList();
      } else {
        filterLeaves();
      }

      noData.value = filteredLeaveHistory.isEmpty;
    } catch (e) {
      print('Error fetching leave history: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterLeaves() {
    final startDate = selectedStartDate.value;
    final endDate = selectedEndDate.value;

    if ((startDate != null && endDate == null) ||
        (startDate == null && endDate != null)) {
      Get.snackbar('Error', 'Data harus diisi semua');
      return;
    }

    filteredLeaveHistory.value = leaveHistory.where((leave) {
      final matchesNip =
          selectedNip.value == null || leave.nip == selectedNip.value;

      final matchesStatus = selectedStatus.value == null ||
          selectedStatus.value == 'All' ||
          leave.status == selectedStatus.value;

      final matchesCompany = selectedUser.value == null ||
          selectedUser.value == 'All' ||
          '${leave.firstName} ${leave.lastName}' == selectedUser.value;

      final leaveStartDate = DateTime.parse(leave.startDate ?? '');

      final matchesDateRange = (startDate == null && endDate == null) ||
          (startDate != null &&
              endDate != null &&
              leaveStartDate.isAtLeast(startDate) &&
              leaveStartDate.isAtMost(endDate));

      return matchesNip && matchesStatus && matchesDateRange && matchesCompany;
    }).toList();

    noData.value = filteredLeaveHistory.isEmpty;
  }

  Future<void> fetchUserItems() async {
    try {
      final data = await _userRepository.fetchAllUser();
      userItems.value = data
          .map<String>((item) => item['full_name'].toString())
          .toSet()
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user items : $e');
    }
  }

  void resetFilter() {
    selectedStatus.value = 'All';
    selectedEndDate.value = null;
    selectedStartDate.value = null;
    selectedUser.value = 'All';
    startDateController.value.clear();
    endDateController.value.clear();
  }

  bool get isOnUserPage => selectedNip.value != null;
}
