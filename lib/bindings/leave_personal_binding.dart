import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/leave_personal_controller.dart';
import 'package:nextbasis_hris/data/repo/leave_history_repository.dart';

class LeavePersonalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveHistoryRepository>(() => LeaveHistoryRepository());
    Get.lazyPut<LeavePersonalController>(() => LeavePersonalController());
  }
}
