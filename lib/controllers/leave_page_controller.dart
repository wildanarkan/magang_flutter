import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/leave_model.dart';


class LeavePageController extends GetxController {
  var leaves = <Leaves>[].obs;  // Observable list to hold leave data
  var isLoading = true.obs;     // Observable to track loading status

  @override
  void onInit() {
    super.onInit();
    fetchLeaves();  // Call your data fetching function when controller initializes
  }

  void fetchLeaves() async {
    try {
      isLoading(true); // Set loading status to true before fetching data
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse(URLs.leaveList),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['leaves'] != null) {
          final leaveModel = LeaveModel.fromJson(data);
          leaves.value = leaveModel.leaves ?? [];
        } else {
          leaves.value = [];
        }
      } else {
        print('Failed to load leave data: ${response.statusCode}');
        leaves.value = []; // Clear the leaves list if loading failed
      }
    } catch (e) {
      print('Error occurred: $e');
      leaves.value = []; // Clear the leaves list if an error occurred
    } finally {
      isLoading(false); // Set loading status to false after fetching data
    }
  }
}

