import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/code_otp_controller.dart';

class CodeOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CodeOtpController>(() => CodeOtpController());
  }
}
