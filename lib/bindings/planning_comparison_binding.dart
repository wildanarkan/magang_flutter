import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/planning_comparison_controller.dart';

class PlanningComparisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanningComparisonController>(() => PlanningComparisonController());
  }
}