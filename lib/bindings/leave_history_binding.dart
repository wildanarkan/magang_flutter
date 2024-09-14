import 'package:get/get.dart';
import 'package:magang_flutter/controllers/leave_page_controller.dart';

class LeaveHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeavePageController>(() => LeavePageController());
  }
}
