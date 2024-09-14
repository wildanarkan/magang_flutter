import 'package:get/get.dart';
import 'package:magang_flutter/controllers/edit_profile_page_controller.dart';

class ProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfilePageController>(() => EditProfilePageController());
  }
}
