import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/data/models/leave_model.dart';
import 'package:magang_flutter/data/repo/leave_history_repository.dart';
import 'package:magang_flutter/data/repo/user_repository.dart';

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

class LeaveHistoryPageController extends GetxController {
  // Repository
  final LeaveHistoryRepository _leaveHistoryRepository =
      Get.find<LeaveHistoryRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();

  var leaves = <Leaves>[].obs; // Observable list to hold leave data
  var isLoading = true.obs; // Observable to track loading status

  var filteredLeaveHistory = <Leaves>[].obs;
  var leaveHistory = <Leaves>[].obs;

  var userItems = <String>[].obs;

  // Variable
  var selectedStatus = Rxn<String>();
  var selectedUser = Rxn<String>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedStartDate = Rxn<DateTime>();

  // Text Editing Controller
  var endDateController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;

  var noData = false.obs;
  var pending = true.obs;

  @override
  void onInit() async {
    if (Get.arguments != null && Get.arguments['pendingPage'] == true) {
      selectedStatus.value = 'Pending';
    }

    super.onInit();
    await fetchLeaves();
    fetchUserItems();
    resetFilter();
  }

  // void filterByNip(String nip) {
  //   filteredLeaveHistory.value =
  //       leaveHistory.where((leave) => leave.nip == nip).toList();
  // }

  Future<void> fetchLeaves() async {
    try {
      isLoading(true);
      final leaves = await _leaveHistoryRepository.fetchAll();
      leaveHistory.value = leaves;

      if (selectedStatus.value == 'Pending') {
        // Filter data yang hanya berstatus Pending
        filteredLeaveHistory.value =
            leaveHistory.where((leave) => leave.status == 'Pending').toList();
      } else {
        filterLeaves(); // Filter sesuai status dan data lainnya
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

      return matchesStatus && matchesDateRange && matchesCompany;
    }).toList();

    noData.value = filteredLeaveHistory.isEmpty;
  }

  void fetchUserItems() async {
    try {
      final data = await _userRepository.fetchAllUser();
      userItems.value = data
          .map<String>((item) => item['full_name'].toString())
          .toSet()
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user items');
    }
  }

  Leaves? getTripById(int id) {
    return leaveHistory.firstWhereOrNull((leave) => leave.id == id);
  }

  void resetFilter() {
    selectedStatus.value = 'All';
    selectedEndDate.value = null;
    selectedStartDate.value = null;
    selectedUser.value = 'All';
    startDateController.value.clear();
    endDateController.value.clear();
  }
}
