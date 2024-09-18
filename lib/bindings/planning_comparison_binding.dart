import 'package:get/get.dart';
import 'package:magang_flutter/controllers/planning_comparison_controller.dart';

class PlanningComparisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanningComparisonController>(() => PlanningComparisonController());
  }
}