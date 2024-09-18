import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/trip_detail_controller.dart';
import 'package:nextbasis_hris/data/models/business_trip_model.dart';

class TripDetailBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<TripDetailController>(() {
      final BusinessTripModel trip = Get.arguments['trip'] as BusinessTripModel;
      return TripDetailController(trip: trip);
    });
  }
}
