import 'package:get/get.dart';
import 'package:magang_flutter/controllers/business_trip_controller.dart';
import 'package:magang_flutter/controllers/home_page_controller.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/controllers/profile_page_controller.dart';
import 'package:magang_flutter/data/repo/business_trip_repository.dart';
import 'package:magang_flutter/data/repo/company_repository.dart';

class NavigatorBinding extends Bindings {
  @override
  void dependencies() {
    // Inisialisasi Repository
    Get.lazyPut<BusinessTripRepository>(() => BusinessTripRepository());
    Get.lazyPut<CompanyRepository>(() => CompanyRepository());

    // Inisialisasi Controller
    Get.lazyPut<NavigatorPageControllers>(() => NavigatorPageControllers());
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<BusinessTripController>(() => BusinessTripController());
    Get.lazyPut<ProfilePageController>(() => ProfilePageController());
  }
}
