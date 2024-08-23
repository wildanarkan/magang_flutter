import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/leave_page_controller.dart';

class LeaveRequestDetailController extends GetxController {
  Future<void> updateLeaveStatus(int leaveId, String status) async {
    try {
      final token = GetStorage().read('accessToken');
      final url = Uri.parse('${URLs.leaveUpdate}$leaveId');
      print('URL: $url');

      final response = await http.put(
        url, // Ganti dengan URL API yang sesuai
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        final leaveController = Get.find<LeavePageController>();
        Get.back();
        leaveController.fetchLeaves();
        Get.snackbar('Success', 'Leave status updated to $status');
      } else {
        Get.snackbar(
            'Error', 'Failed to update leave status: ${response.statusCode}');
      }
      log(response.statusCode);
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> deleteLeave(int leaveId) async {
    try {
      final token = GetStorage().read('accessToken');
      final url = Uri.parse('${URLs.leave}$leaveId');
      print('URL: $url');

      final response = await http.delete(
        url, // Ganti dengan URL API yang sesuai
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final leaveController = Get.find<LeavePageController>();
        Get.back();
        leaveController.fetchLeaves();
        Get.snackbar('Success', 'Leave request deleted');
      } else {
        Get.snackbar(
            'Error', 'Failed to delete leave request: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
