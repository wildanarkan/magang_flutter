import 'package:get/get.dart';
import 'package:magang_flutter/controllers/leave_history_page_controller.dart';
import 'package:magang_flutter/controllers/leave_personal_page_controller.dart';
import 'package:magang_flutter/data/repo/leave_history_repository.dart';

class LeaveHistoryDetailPageController extends GetxController {
  final LeaveHistoryRepository _leaveHistoryRepository =
      LeaveHistoryRepository();

  final leaveController = Get.find<LeaveHistoryPageController>();
  final leavePersonalPageController = Get.find<LeavePersonalPageController>();

  Future<void> updateLeaveStatus(int leaveId, String status) async {
    bool isSuccess = await _leaveHistoryRepository.updateLeaveStatus(leaveId, status);

    if (isSuccess) {
      Get.back(closeOverlays: true);
      leaveController.fetchLeaves();
      leavePersonalPageController.fetchLeaves();
      Get.snackbar('Success', 'Leave status updated to $status');
    } else {
      Get.snackbar('Error', 'Failed to update leave status');
    }
  }
}
