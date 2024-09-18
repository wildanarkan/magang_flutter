import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/app_endpoint.dart';


class CompanyRepository extends GetxService {
  final storage = GetStorage();

  Future<List<Map<String, dynamic>>> fetchCompany() async {
    final token = storage.read('accessToken');
    final response = await http.get(
      Uri.parse(AppEndpoint.company),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load data company');
    }
  }

  Future<List<dynamic>> fetchCompanyCity() async {
    final token = storage.read('accessToken');
    final response = await http.get(
      Uri.parse(AppEndpoint.companyCity),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data company');
    }
  }
}
