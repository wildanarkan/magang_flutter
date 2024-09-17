import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';


class CityRepository extends GetxService {
  final storage = GetStorage();

  Future<List<Map<String, dynamic>>> fetchCity() async {
    final token = storage.read('accessToken');
    final response = await http.get(
      Uri.parse(URLs.city),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load data city');
    }
  }
}