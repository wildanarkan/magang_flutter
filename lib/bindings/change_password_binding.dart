import 'package:get/get.dart';
import 'package:magang_flutter/controllers/change_password_page_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordPageController>(() => ChangePasswordPageController());
  }
}
