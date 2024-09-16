import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/leave_model.dart';

class LeaveHistoryRepository extends GetxService {
  final storage = GetStorage();

  Future<List<Leaves>> fetchAll() async {
    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.leave),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // First, parse the entire JSON object
        final jsonData = json.decode(response.body);

        // Then, extract the list from the 'leaves' key
        if (jsonData['leaves'] != null) {
          List<dynamic> leavesList = jsonData['leaves'];
          return leavesList.map((json) => Leaves.fromJson(json)).toList();
        } else {
          throw Exception('No leaves found');
        }
      } else {
        throw Exception('Failed to load leaves');
      }
    } catch (e) {
      throw Exception('Error fetching leaves: $e');
    }
  }
}
