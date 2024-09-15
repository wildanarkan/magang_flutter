import 'package:get/get.dart';
import 'package:magang_flutter/controllers/edit_biaya_page_controller.dart';

class PlanningEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditBiayaPageController>(() {
      final args = Get.arguments as Map<String, dynamic>;
      return EditBiayaPageController(
        idBusinessTrip: args['idBusinessTrip'],
        idItem: args['idItem'],
      );
    });
  }
}