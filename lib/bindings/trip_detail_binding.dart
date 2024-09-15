import 'package:get/get.dart';
import 'package:magang_flutter/controllers/business_trip_detail_page_controller.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';

class TripDetailBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<BusinessTripDetailPageController>(() {
      final BusinessTripModel trip = Get.arguments['trip'] as BusinessTripModel;
      return BusinessTripDetailPageController(trip: trip);
    });
  }
}
