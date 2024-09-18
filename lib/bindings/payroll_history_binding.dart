import 'package:get/get.dart';
import 'package:magang_flutter/controllers/payroll_history_controller.dart';

class PayrollHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayrollHistoryController>(() => PayrollHistoryController());
  }
}