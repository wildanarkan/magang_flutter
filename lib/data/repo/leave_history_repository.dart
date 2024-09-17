import 'dart:convert';
import 'dart:developer';

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
        final jsonData = json.decode(response.body);
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

  Future<List<Leaves>> fetchByUserId() async {
    final userId = storage.read('userId');
    if (userId == null) {
      print('User ID not found');
      return []; // Return empty list instead of null
    }

    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse('${URLs.leaveUser}$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['leaves'] != null) {
          List<dynamic> leavesList = jsonData['leaves'];
          return leavesList.map((json) => Leaves.fromJson(json)).toList();
        } else {
          print('No leaves found');
          return [];
        }
      } else {
        log('Failed to load leaves by user');
        log(response.statusCode.toString());
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<List<dynamic>?> fetchCategoryItems() async {
    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.leaveCategory),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
