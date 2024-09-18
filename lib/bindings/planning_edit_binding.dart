import 'package:get/get.dart';
import 'package:magang_flutter/controllers/planning_update_controller.dart';

class PlanningEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanningUpdateController>(() {
      final args = Get.arguments as Map<String, dynamic>;
      return PlanningUpdateController(
        idBusinessTrip: args['idBusinessTrip'],
        idItem: args['idItem'],
      );
    });
  }
}