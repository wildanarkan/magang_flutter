import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/payroll_model.dart';

class PayrollHistoryPageController extends GetxController {
  RxList<Payrolls> payrolls = <Payrolls>[].obs;
  Rx<Payrolls?> payrollDetail = Rx<Payrolls?>(null);
  RxBool isLoading = false.obs; // Tambahkan state loading

  @override
  void onInit() {
    super.onInit();
    fetchPayrolls();
  }

  Future<void> fetchPayrolls() async {
    isLoading.value = true; // Mulai loading
    final userId = GetStorage().read('userId');
    if (userId == null) {
      print('User ID not found');
      return;
    }

    try {
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse('${URLs.payrolls}$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['payrolls'] != null) {
          final payrollModel = PayrollModel.fromJson(data);
          payrolls.value = payrollModel.payrolls ?? [];
        } else {
          payrolls.value = [];
        }
      } else {
        print('Failed to load payroll data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isLoading.value = false; // Selesai loading
    }
  }

  Future<void> fetchPayrollDetail(String payrollId) async {
    isLoading.value = true; // Mulai loading
    final token = GetStorage().read('accessToken');
    final url = '${URLs.payroll}$payrollId';

    try {
      print('Fetching payroll detail from: $url'); // Log URL endpoint
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data received: $data');
        if (data['payroll'] != null) {
          payrollDetail.value = Payrolls.fromJson(data['payroll']);
          print('Payroll detail updated: ${payrollDetail.value}');
        } else {
          print('No payroll detail found in response.');
        }
      } else {
        print('Failed to load payroll detail data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isLoading.value = false; // Selesai loading
    }
  }
}
