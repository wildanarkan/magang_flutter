import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';

class PayrollHistoryPageController extends GetxController {
  RxList<Map<String, dynamic>> payrolls = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPayrolls();
  }

  Future<void> fetchPayrolls() async {
    final userId = GetStorage().read('userId');
    if (userId == null) {
      print('User ID not found');
      return;
    }

    try {
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse('${URLs.payroll}$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Berhasil mendapatkan data
        final data = json.decode(response.body);
        if (data['payrolls'] is List) {
          payrolls.value = List<Map<String, dynamic>>.from(data['payrolls']);
        } else {
          payrolls.value = [];
        }
      } else {
        print('Failed to load payroll data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
