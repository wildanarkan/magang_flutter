import 'package:get/get.dart';
import 'package:magang_flutter/data/models/payroll_model.dart';
import 'package:magang_flutter/data/repo/user_repository.dart';

class PayrollHistoryPageController extends GetxController {
  // Repository 
   final UserRepository _userRepository = UserRepository();
   
  RxList<Payrolls> payrolls = <Payrolls>[].obs;
  Rx<Payrolls?> payrollDetail = Rx<Payrolls?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPayrolls();
  }

    Future<void> fetchPayrolls() async {
    isLoading.value = true;
    payrolls.value = await _userRepository.fetchPayrolls();
    isLoading.value = false;
  }

  Future<void> fetchPayrollDetail(String payrollId) async {
    isLoading.value = true;
    payrollDetail.value = await _userRepository.fetchPayrollDetail(payrollId);
    isLoading.value = false;
  }
}
