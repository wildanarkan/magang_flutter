import 'package:get/get.dart';
import 'package:magang_flutter/controllers/trip_add_controller.dart';

class TripAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripAddController>(() => TripAddController());
  }
}
