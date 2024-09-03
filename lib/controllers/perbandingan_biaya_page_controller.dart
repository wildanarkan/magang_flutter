import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/business_calculate_model.dart';
import 'package:magang_flutter/data/models/business_percentage_model.dart';

class PerbandinganBiayaPageController extends GetxController {
  RxList<BusinessPercentageModel> percentages = <BusinessPercentageModel>[].obs;
  Rx<BusinessCalculateModel?> calculation = Rx<BusinessCalculateModel?>(null);
  RxBool isLoading = false.obs;

  Future<void> fetchComparisonData(int idBusinessTrip) async {
    isLoading.value = true;
    final token = GetStorage().read('accessToken') ?? '';
    final urlPercentage = '${URLs.percentage}/$idBusinessTrip';
    final urlCalculate = '${URLs.calculate}/$idBusinessTrip';

    try {
      final responses = await Future.wait([
        http.get(Uri.parse(urlPercentage),
            headers: {'Authorization': 'Bearer $token'}),
        http.get(Uri.parse(urlCalculate),
            headers: {'Authorization': 'Bearer $token'}),
      ]);

      // Handle percentage data
      if (responses[0].statusCode == 200) {
        final List<dynamic> dataPercentage =
            json.decode(responses[0].body) as List<dynamic>;
        percentages.value = dataPercentage
            .map((data) => BusinessPercentageModel.fromJson(data))
            .toList();
      } else {
        print('Failed to load percentage data: ${responses[0].statusCode}');
        percentages.value = [];
      }

      // Handle calculation data
      if (responses[1].statusCode == 200) {
        final Map<String, dynamic> dataCalculate =
            json.decode(responses[1].body);
        calculation.value = BusinessCalculateModel.fromJson(dataCalculate);
      } else {
        print('Failed to load calculation data: ${responses[1].statusCode}');
        calculation.value = null;
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, dynamic> getComparisonData() {
    return {
      'percentages': percentages.map((e) => e.toJson()).toList(),
      'totalNominalPlanning': calculation.value?.totalNominalPlanning ?? '0',
      'totalNominalRealization':
          calculation.value?.totalNominalRealization ?? '0',
      'difference': calculation.value?.difference ?? '0',
    };
  }
}
