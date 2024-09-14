import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';

class BusinessTripRepository extends GetxService {
  final storage = GetStorage();

  Future<List<BusinessTripModel>> fetchCurrent() async {
    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.tripToday),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((json) => BusinessTripModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load business trips');
      }
    } catch (e) {
      throw Exception('Error fetching business trips: $e');
    }
  }

  Future<List<BusinessTripModel>> fetchAll() async {
    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.business),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((json) => BusinessTripModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load business trips');
      }
    } catch (e) {
      throw Exception('Error fetching business trips: $e');
    }
  }
}
