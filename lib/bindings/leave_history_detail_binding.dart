import 'package:get/get.dart';
import 'package:magang_flutter/controllers/leave_history_detail_page_controller.dart';
import 'package:magang_flutter/controllers/leave_history_page_controller.dart';
import 'package:magang_flutter/controllers/leave_personal_page_controller.dart';

class LeaveHistoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveHistoryPageController>(() => LeaveHistoryPageController());
    Get.lazyPut<LeaveHistoryDetailPageController>(
        () => LeaveHistoryDetailPageController());
    Get.lazyPut<LeavePersonalPageController>(
        () => LeavePersonalPageController());
  }
}
