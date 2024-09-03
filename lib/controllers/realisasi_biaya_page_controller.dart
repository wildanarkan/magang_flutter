import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/nominal_model.dart';

class RealisasiBiayaPageController extends GetxController {
  final int idBusinessTrip; // Tambahkan variabel instansi

  RxBool isLoading = false.obs;
  RxMap<String, List<NominalModel>> groupedData =
      RxMap<String, List<NominalModel>>({});

  RealisasiBiayaPageController(
      {required this.idBusinessTrip}); // Tambahkan parameter ke konstruktor

  @override
  void onInit() {
    super.onInit();
    fetchNominalRealizationData(idBusinessTrip);
  }

  Future<void> fetchNominalRealizationData(int idBusinessTrip) async {
    isLoading.value = true;
    final token = GetStorage().read('accessToken') ?? '';
    final url =
        '${URLs.nominalRealization}/$idBusinessTrip'; // Tambahkan ID ke URL

    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

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

        groupedData.value = grouped;
      } else {
        print('Gagal memuat data: ${response.statusCode}');
        groupedData.value = {};
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      groupedData.value = {};
    } finally {
      isLoading.value = false;
    }
  }

  void updateData() {
    fetchNominalRealizationData(idBusinessTrip);
  }

  String calculateTotal() {
    final total = groupedData.value.values.expand((items) => items).fold(0.0,
        (sum, item) {
      final cleanNominal = item.nominal?.toString() ?? '0';
      final normalizedNominal = cleanNominal.replaceAll(',', '.');
      return sum + (double.tryParse(normalizedNominal) ?? 0.0);
    });

    final formattedTotal = total.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(\.|$))'),
          (Match m) => '${m[1]}.',
        );

    return 'Rp $formattedTotal';
  }
}
