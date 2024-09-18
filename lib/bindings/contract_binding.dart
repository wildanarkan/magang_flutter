import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/contract_history_controller.dart';

class ContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractHistoryPageController>(() => ContractHistoryPageController());
  }
}
