import 'package:get/get.dart';
import 'package:magang_flutter/controllers/leave_history_page_controller.dart';
import 'package:magang_flutter/controllers/leave_personal_page_controller.dart';
import 'package:magang_flutter/data/repo/leave_history_repository.dart';

class LeaveHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveHistoryRepository>(() => LeaveHistoryRepository());
    Get.lazyPut<LeaveHistoryPageController>(() => LeaveHistoryPageController());
    Get.lazyPut<LeavePersonalPageController>(() => LeavePersonalPageController());

  }
}
