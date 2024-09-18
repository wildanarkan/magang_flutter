import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/planning_controller.dart';
import 'package:nextbasis_hris/data/repo/planning_repository.dart';

class PlanningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanningRepository>(() => PlanningRepository());
    Get.lazyPut<PlanningController>(() {
      final args = Get.arguments as Map<String, dynamic>;
      return PlanningController(
        idBusinessTrip: args['idBusinessTrip'],
        biayaType: args['biayaType'],
      );
    });
  }
}
