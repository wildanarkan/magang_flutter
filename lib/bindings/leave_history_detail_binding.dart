import 'package:get/get.dart';
import 'package:magang_flutter/controllers/leave_history_controller.dart';
import 'package:magang_flutter/controllers/leave_history_detail_controller.dart';
import 'package:magang_flutter/controllers/leave_personal_controller.dart';

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
