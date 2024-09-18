import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/leave_history_controller.dart';
import 'package:nextbasis_hris/controllers/leave_history_detail_controller.dart';
import 'package:nextbasis_hris/controllers/leave_personal_controller.dart';

class LeaveHistoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveHistoryController>(() => LeaveHistoryController());
    Get.lazyPut<LeaveHistoryDetailController>(
        () => LeaveHistoryDetailController());
    Get.lazyPut<LeavePersonalController>(
        () => LeavePersonalController());
  }
}
