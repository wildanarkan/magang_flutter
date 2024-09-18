import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/profile_update_controller.dart';

class ProfileUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileUpdateController>(() => ProfileUpdateController());
  }
}
