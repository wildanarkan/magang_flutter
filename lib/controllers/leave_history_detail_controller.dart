import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/leave_history_controller.dart';
import 'package:nextbasis_hris/controllers/leave_personal_controller.dart';
import 'package:nextbasis_hris/data/repo/leave_history_repository.dart';

class LeaveHistoryDetailController extends GetxController {
  final LeaveHistoryRepository _leaveHistoryRepository =
      LeaveHistoryRepository();

  final leaveController = Get.find<LeaveHistoryController>();
  final leavePersonalPageController = Get.find<LeavePersonalController>();

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
