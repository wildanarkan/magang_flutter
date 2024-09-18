import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nextbasis_hris/common/app_endpoint.dart';
import 'package:nextbasis_hris/data/models/business_calculate_model.dart';
import 'package:nextbasis_hris/data/models/business_percentage_model.dart';
import 'package:nextbasis_hris/data/models/nominal_model.dart';

class PlanningRepository extends GetxService {
  final storage = GetStorage();

  Future<Map<String, List<NominalModel>>> fetchNominalData(
      int idBusinessTrip, String biayaType) async {
    final token = GetStorage().read('accessToken') ?? '';
    final url = biayaType == 'estimasi'
        ? '${AppEndpoint.nominalPlanning}/$idBusinessTrip'
        : '${AppEndpoint.nominalRealization}/$idBusinessTrip';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        final grouped = <String, List<NominalModel>>{};

        for (var item in data) {
          final model = NominalModel.fromJson(item);
          final category = model.categoryExpenditureName ?? 'Unknown';

          if (!grouped.containsKey(category)) {
            grouped[category] = [];
          }
          grouped[category]?.add(model);
        }
        return grouped;
      } else {
        print('Gagal memuat data: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchPlanningComparison(
      int idBusinessTrip) async {
    final token = GetStorage().read('accessToken') ?? '';
    final urlPercentage = '${AppEndpoint.percentage}/$idBusinessTrip';
    final urlCalculate = '${AppEndpoint.calculate}/$idBusinessTrip';

    try {
      final responses = await Future.wait([
        http.get(Uri.parse(urlPercentage),
            headers: {'Authorization': 'Bearer $token'}),
        http.get(Uri.parse(urlCalculate),
            headers: {'Authorization': 'Bearer $token'}),
      ]);

      List<BusinessPercentageModel> percentages = [];
      if (responses[0].statusCode == 200) {
        final List<dynamic> dataPercentage =
            json.decode(responses[0].body) as List<dynamic>;
        percentages = dataPercentage
            .map((data) => BusinessPercentageModel.fromJson(data))
            .toList();
      } else {
        print('Failed to load percentage data: ${responses[0].statusCode}');
      }

      BusinessCalculateModel? calculation;
      if (responses[1].statusCode == 200) {
        final Map<String, dynamic> dataCalculate =
            json.decode(responses[1].body);
        calculation = BusinessCalculateModel.fromJson(dataCalculate);
      } else {
        print('Failed to load calculation data: ${responses[1].statusCode}');
      }

      return {
        'percentages': percentages,
        'calculation': calculation,
      };
    } catch (e) {
      print('Error occurred: $e');
      return {};
    }
  }

  Future<bool> updateRealization({
    required int idItem,
    required String keterangan,
    required String nominal,
    File? photoProof,
    required int idBusinessTrip,
  }) async {
    try {
      final token = GetStorage().read('accessToken');
      final uri = Uri.parse('${AppEndpoint.putRealization}$idItem');

      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token';

      request.fields['keterangan'] = keterangan;
      request.fields['nominal'] = nominal;

      if (photoProof != null) {
        final file = await http.MultipartFile.fromPath(
          'photo_proof',
          photoProof.path,
        );
        request.files.add(file);
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Error to update Data');
        return false;
      }
    } catch (e) {
      log('An error occurred: $e');
      return false;
    }
  }

  Future<List<dynamic>> fetchCategoryExpenditure() async {
    try {
      final token = GetStorage().read('accessToken');
      final response = await http.get(
        Uri.parse(AppEndpoint.categoryExpenditure),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load company items');
      }
    } catch (e) {
      throw Exception('Failed to load company items: $e');
    }
  }

  Future<bool> postRealization({
    required String idBusinessTrip,
    required String selectedCategoryId,
    required String nominal,
    required String keterangan,
    List<http.MultipartFile>? files,
  }) async {
    final token = storage.read('accessToken');
    final uri = Uri.parse(AppEndpoint.addBusiness);
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token';
    request.fields['id_business_trip'] = idBusinessTrip;
    request.fields['id_category_expenditure'] = selectedCategoryId;
    request.fields['nominal'] = nominal;
    request.fields['keterangan'] = keterangan;

    if (files != null) {
      request.files.addAll(files);
    }

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        return true;
      } else {
        final responseBody = await response.stream.bytesToString();
        log(responseBody);
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
