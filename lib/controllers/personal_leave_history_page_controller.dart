import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/leave_model.dart';

class PersonalLeaveHistoryPageController extends GetxController {
  RxList<Leaves> leaves = <Leaves>[].obs;
  RxBool isLoading = false.obs;
  var statusFilter = ''.obs; // Add this for status filtering

  @override
  void onInit() {
    super.onInit();
    fetchByUserId(); // Memanggil metode fetchByUserId saat controller diinisialisasi
  }

  Future<void> fetchByUserId() async {
    final userId = GetStorage().read('userId');
    if (userId == null) {
      print('User ID not found');
      return;
    }

    try {
      isLoading.value = true;
      final token = GetStorage().read('accessToken');
      final response = await http.get(
        Uri.parse('${URLs.leave}$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('API Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['leaves'] != null) {
          final leaveModel = LeaveModel.fromJson(data);
          leaves.value = leaveModel.leaves ?? [];
          print('Leaves data updated: ${leaves.value}');
        } else {
          leaves.value = [];
          print('No leaves data found.');
        }
      } else {
        print('Failed to load leaves data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<Leaves> get filteredLeaves {
    if (statusFilter.value.isNotEmpty) {
      return leaves.where((leave) => leave.status == statusFilter.value).toList();
    }
    return leaves;
  }
}
