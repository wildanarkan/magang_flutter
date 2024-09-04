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
  var isLoading = true.obs;

  var startTime = ''.obs;
  var endTime = ''.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentBusinessTrips();
    _loadStartTime();
    _updateEndTime();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateEndTime();
    });
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
        log('Success fetch trip');
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
    if (storedStartTime == null || !_isToday(storedStartTime)) {
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
