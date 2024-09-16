import 'package:get/get.dart';
import 'package:magang_flutter/controllers/leave_request_detail_controller_page.dart';

class LeaveHistoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveRequestDetailController>(() => LeaveRequestDetailController());
  }
}
