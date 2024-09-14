import 'package:get/get.dart';
import 'package:magang_flutter/controllers/add_businiess_trip_page_controller.dart';

class TripAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBusiniessTripPageController>(() => AddBusiniessTripPageController());
  }
}
