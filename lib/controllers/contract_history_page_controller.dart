import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';

class ContractHistoryPageController extends GetxController {
  RxList<Map<String, dynamic>> contracts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchContracts();
  }

  Future<void> fetchContracts() async {
    final userId = GetStorage().read('userId');
    if (userId == null) {
      print('User ID not found');
      return;
    }

    try {
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse('${URLs.contract}$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Berhasil mendapatkan data
        final data = json.decode(response.body);
        if (data['contracts'] is List) {
          contracts.value = List<Map<String, dynamic>>.from(data['contracts']);
        } else {
          contracts.value = [];
        }
      } else {
        print(userId);
        // Error handling
        print('Failed to load contract data: ${response.statusCode}');
      }
    } catch (e) {
      // Error handling untuk koneksi atau lainnya
      print('Error occurred: $e');
    }
  }
}
