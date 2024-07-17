import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BalanceSheetDetailPageController extends GetxController {

  final DateTime now = DateTime.now();
  final RxString formattedDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    formattedDate.value = DateFormat('EEEE, d-MM-yyyy').format(now);
  }

}
