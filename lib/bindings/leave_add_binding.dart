import 'package:get/get.dart';
import 'package:magang_flutter/controllers/leave_add_controller.dart';

class LeaveAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveAddController>(() => LeaveAddController());
  }
}
