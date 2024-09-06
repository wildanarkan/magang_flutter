import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';

class HomePageController extends GetxController {
  var currentBusinessTrip = <BusinessTripModel>[].obs;
  var savedBusinessTrips = <BusinessTripModel>[].obs;
  var isLoading = true.obs;

  String startDate = '--:--';
  String endDate = '--:--';

  var startTime = ''.obs;
  var endTime = ''.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentBusinessTrips();
    loadSavedBusinessTrips();
    _loadStartTime();
    _updateEndTime();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateEndTime();
    });
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

  void _loadStartTime() {
    String? storedStartTime = storage.read('startTime');
    if (!_isToday(storedStartTime!)) {
      startTime.value = DateFormat.Hm().format(DateTime.now());
      storage.write('startTime', startTime.value);
    } else {
      startTime.value = storedStartTime;
    }
  }

  void _updateEndTime() {
    endTime.value = DateFormat.Hm().format(DateTime.now());
  }

  bool _isToday(String time) {
    DateTime now = DateTime.now();
    DateTime storedTime = DateFormat.Hm().parse(time);
    return now.day == storedTime.day &&
        now.month == storedTime.month &&
        now.year == storedTime.year;
  }
}
