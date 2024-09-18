import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/home_controller.dart';
import 'package:nextbasis_hris/controllers/navigator_controllers.dart';
import 'package:nextbasis_hris/controllers/profile_controller.dart';
import 'package:nextbasis_hris/controllers/trip_controller.dart';
import 'package:nextbasis_hris/data/repo/business_trip_repository.dart';
import 'package:nextbasis_hris/data/repo/company_repository.dart';

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
