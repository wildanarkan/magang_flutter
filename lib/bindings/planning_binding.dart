import 'package:get/get.dart';
import 'package:magang_flutter/controllers/nominal_page_controller.dart';
import 'package:magang_flutter/data/repo/planning_repository.dart';

class PlanningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanningRepository>(() => PlanningRepository());
    Get.lazyPut<NominalPageController>(() {
      final args = Get.arguments as Map<String, dynamic>;
      return NominalPageController(
        idBusinessTrip: args['idBusinessTrip'],
        biayaType: args['biayaType'],
      );
    });
  }
}
