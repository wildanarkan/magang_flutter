import 'package:get/get.dart';
import 'package:magang_flutter/controllers/home_controller.dart';
import 'package:magang_flutter/controllers/navigator_controllers.dart';
import 'package:magang_flutter/controllers/profile_controller.dart';
import 'package:magang_flutter/controllers/trip_controller.dart';
import 'package:magang_flutter/data/repo/business_trip_repository.dart';
import 'package:magang_flutter/data/repo/company_repository.dart';

class NavigatorBinding extends Bindings {
  @override
  void dependencies() {
    // Inisialisasi Repository
    Get.lazyPut<BusinessTripRepository>(() => BusinessTripRepository());
    Get.lazyPut<CompanyRepository>(() => CompanyRepository());

    // Inisialisasi Controller
    Get.lazyPut<NavigatorControllers>(() => NavigatorControllers());
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<TripController>(() => TripController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
