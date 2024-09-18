import 'package:get/get.dart';
import 'package:magang_flutter/data/repo/user_repository.dart';

class ContractHistoryPageController extends GetxController {
  // Repository
  final UserRepository userRepository = UserRepository();
  
  RxList<Map<String, dynamic>> contracts = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContracts();
  }

  Future<void> fetchContracts() async {
    isLoading.value = true;
    final result = await userRepository.fetchContracts();
    contracts.value = result;
    isLoading.value = false;
  }
}
