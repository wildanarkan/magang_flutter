import 'package:get/get.dart';
import 'package:magang_flutter/controllers/trip_detail_controller.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';

class TripDetailBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<TripDetailController>(() {
      final BusinessTripModel trip = Get.arguments['trip'] as BusinessTripModel;
      return TripDetailController(trip: trip);
    });
  }
}
