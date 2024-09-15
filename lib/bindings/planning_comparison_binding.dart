import 'package:get/get.dart';
import 'package:magang_flutter/controllers/perbandingan_biaya_page_controller.dart';

class PlanningComparisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerbandinganBiayaPageController>(() => PerbandinganBiayaPageController());
  }
}