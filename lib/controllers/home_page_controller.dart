import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';

class HomePageController extends GetxController {
  var currentBusinessTrip = <BusinessTripModel>[].obs;
  var savedBusinessTrips = <BusinessTripModel>[].obs;
  var isLoading = false.obs;

  var startTime = '--:--'.obs;
  var endTime = '--:--'.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentBusinessTrips();
    loadSavedBusinessTrips();
    _loadStoredTimes();
  }

  void _loadStoredTimes() {
    startTime.value = storage.read('startTime') ?? '--:--';
    endTime.value = storage.read('endTime') ?? '--:--';
  }

  void updateStartTime(String time) {
    startTime.value = time;
    storage.write('startTime', time);
  }

  void updateEndTime(String time) {
    endTime.value = time;
    storage.write('endTime', time);
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
      final token = GetStorage().read('accessToken');
      final response = await http.post(
        Uri.parse(URLs.checkInActivity),
        body: json.encode({
          'latitude': position.latitude,
          'longtitude': position.longitude,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final now = DateTime.now();
        final formattedTime = DateFormat('HH:mm').format(now);

        if (data['message'].contains('Check-in')) {
          updateStartTime(formattedTime);
          Get.snackbar('Success', 'Check-in successful');
        } else if (data['message'].contains('Check-out')) {
          updateEndTime(formattedTime);
          Get.snackbar('Success', 'Check-out successful');
        }
      } else if (response.statusCode == 400) {
        final data = json.decode(response.body);
        Get.snackbar('Error', data['message']);
      } else {
        log(URLs.checkInActivity);
        log(response.statusCode.toString());
        Get.snackbar('Error', 'An unexpected error occurred');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
      log('Error in checkInOut: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
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

  Future<void> fetchCurrentBusinessTrips() async {
    try {
      isLoading(true);
      final token = GetStorage().read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.tripToday),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        log('Success fetch current trip');
        print('Semua data di GetStorage:');
        storage.getKeys().forEach((key) {
          print('$key: ${storage.read(key)}');
        });
        List<dynamic> jsonData = json.decode(response.body);
        currentBusinessTrip.value =
            jsonData.map((json) => BusinessTripModel.fromJson(json)).toList();
      } else {
        // Handle error
        print(response.statusCode);
      }
    } catch (e) {
      // Handle exception
    } finally {
      isLoading(false);
    }
  }
}
