import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nextbasis_hris/data/models/business_trip_model.dart';
import 'package:nextbasis_hris/data/repo/business_trip_repository.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

class HomePageController extends GetxController {
  var currentBusinessTrip = <BusinessTripModel>[].obs;
  var savedBusinessTrips = <BusinessTripModel>[].obs;
  var isLoading = false.obs;

  var startTime = '--:--'.obs;
  var endTime = '--:--'.obs;
  final storage = GetStorage();

  final BusinessTripRepository _businessTripRepository =
      Get.find<BusinessTripRepository>();
  final UserRepository userRepository = Get.find<UserRepository>();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentBusinessTrips();
    fetchCheckinToday();
    loadSavedBusinessTrips();
    _checkDateAndResetTimes();
  }

  Future<void> fetchCurrentBusinessTrips() async {
    try {
      isLoading(true);
      final trips = await _businessTripRepository.fetchCurrent();
      currentBusinessTrip.value = trips;
    } catch (e) {
      print('Error fetching current business trips: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCheckinToday() async {
    log('fetch checkin today');
    try {
      isLoading(true);
      final userId = storage.read('userId');
      final data = await userRepository.fetchCheckinToday(userId);
      for (var item in data) {
        final type = item['type'];
        final time = item['time'];
        if (type == 0) {
          startTime.value = time.substring(11, 16);
        } else if (type == 1) {
          endTime.value = time.substring(11, 16);
        }
      }
    } catch (e) {
      log('Error check today $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error',
          'Location services are disabled. Please enable the services');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error',
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }

    return true;
  }

  Future<void> checkInOut() async {
    try {
      isLoading.value = true;

      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) return;

      final position = await Geolocator.getCurrentPosition();
      final data = await userRepository.checkInOut(
          position.latitude, position.longitude);

      if (data['message'].contains('Check-in')) {
        startTime.value = data['check_in_time'];
        Get.snackbar('Success', 'Check-in successful');
      } else if (data['message'].contains('Check-out')) {
        endTime.value = data['check_out_time'];
        Get.snackbar('Success', 'Check-out successful');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
      log('Error in checkInOut: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void _checkDateAndResetTimes() {
    final lastCheckInDate = storage.read('checkInDate');
    if (lastCheckInDate != null) {
      DateTime lastDate = DateTime.parse(lastCheckInDate);
      DateTime today = DateTime.now();
      if (lastDate.day != today.day ||
          lastDate.month != today.month ||
          lastDate.year != today.year) {
        updateStartTime('--:--');
        updateEndTime('--:--');
        log('kena remove');
        storage.remove('checkInDate');
      }
    }
  }

  void updateStartTime(String time) {
    startTime.value = time;
    storage.write('checkInDate', DateTime.now().toIso8601String());
  }

  void updateEndTime(String time) {
    endTime.value = time;
  }

  void loadSavedBusinessTrips() {
    List<dynamic> savedTripsData =
        GetStorage().read('savedBusinessTrips') ?? [];
    savedBusinessTrips.value =
        savedTripsData.map((trip) => BusinessTripModel.fromJson(trip)).toList();
  }

  bool checkIfSaved(BusinessTripModel trip) {
    return savedBusinessTrips
        .any((savedTrip) => savedTrip.idBusinessTrip == trip.idBusinessTrip);
  }

  void toggleSaveTrip(BusinessTripModel trip) {
    if (checkIfSaved(trip)) {
      // Remove from saved trips
      savedBusinessTrips.removeWhere(
          (savedTrip) => savedTrip.idBusinessTrip == trip.idBusinessTrip);
      Get.snackbar('Success', 'Remove at saved business trip');
    } else if (savedBusinessTrips.length < 2) {
      // Add to saved trips
      savedBusinessTrips.add(trip);
      Get.snackbar('Success', 'Add at saved business trip');
    } else {
      log(savedBusinessTrips.length.toString());
      Get.snackbar('Failed', 'Limit add saved business trip');
    }
    updateStorage();
  }

  void refreshSavedTrips(BusinessTripModel trip) {
    if (checkIfSaved(trip)) {
      savedBusinessTrips.removeWhere(
          (savedTrip) => savedTrip.idBusinessTrip == trip.idBusinessTrip);
      savedBusinessTrips.add(trip);
      log('trip saved');
    } else {
      log('trip tidak saved');
    }
  }

  void updateStorage() {
    GetStorage().write('savedBusinessTrips',
        savedBusinessTrips.map((trip) => trip.toJson()).toList());
  }
}
