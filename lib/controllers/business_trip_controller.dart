import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';

class BusinessTripController extends GetxController {
  var businessTrips = <BusinessTripModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchBusinessTrips();
    super.onInit();
  }

  Future<void> fetchBusinessTrips() async {
    try {
      isLoading(true);
            final token = GetStorage().read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.business),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );


      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        businessTrips.value = jsonData.map((json) => BusinessTripModel.fromJson(json)).toList();
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
