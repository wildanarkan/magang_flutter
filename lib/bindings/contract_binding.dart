import 'package:get/get.dart';
import 'package:magang_flutter/controllers/contract_history_page_controller.dart';

class ContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractHistoryPageController>(() => ContractHistoryPageController());
  }
}
