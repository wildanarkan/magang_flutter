import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/nominal_model.dart';

class NominalPageController extends GetxController {
  final int idBusinessTrip;
  final String biayaType; // 'estimasi' atau 'realisasi'

  RxBool isLoading = false.obs;
  RxMap<String, List<NominalModel>> groupedData =
      RxMap<String, List<NominalModel>>({});

  NominalPageController({
    required this.idBusinessTrip,
    required this.biayaType,
  });

  @override
  void onInit() {
    super.onInit();
    fetchNominalData(idBusinessTrip);
  }

  Future<void> fetchNominalData(int idBusinessTrip) async {
    isLoading.value = true;
    final token = GetStorage().read('accessToken') ?? '';
    final url = biayaType == 'estimasi'
        ? '${URLs.nominalPlanning}/$idBusinessTrip'
        : '${URLs.nominalRealization}/$idBusinessTrip';

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

  String formatIdr(double amount) {
    final isNegative = amount < 0;
    final absoluteValue = amount.abs();

    // Format angka dengan dua desimal dan koma sebagai pemisah desimal
    final formattedValue = absoluteValue
        .toStringAsFixed(2)
        .replaceAll('.', ',') // Mengganti titik desimal dengan koma
        .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'),
            '.'); // Tambahkan titik sebagai pemisah ribuan

    // Kembalikan nilai dengan "Rp" di depan dan tanda minus di belakang jika negatif
    return isNegative ? 'IDR $formattedValue-' : 'IDR $formattedValue';
  }

  String formatCurrency(double amount) {
    final isNegative = amount < 0;
    final absoluteValue = amount.abs();

    // Format angka dengan dua desimal dan koma sebagai pemisah desimal
    final formattedValue = absoluteValue
        .toStringAsFixed(2)
        .replaceAll('.', ',') // Mengganti titik desimal dengan koma
        .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'),
            '.'); // Tambahkan titik sebagai pemisah ribuan

    // Kembalikan nilai dengan "Rp" di depan dan tanda minus di belakang jika negatif
    return isNegative ? 'Rp $formattedValue-' : 'Rp $formattedValue';
  }

  void updateData() {
    fetchNominalData(idBusinessTrip);
  }

  String calculateTotal() {
    final total = groupedData.value.values
        .expand((items) => items)
        .fold<double>(0.0, (sum, item) {
      final cleanNominal = item.nominal?.toString() ?? '0';
      final normalizedNominal = cleanNominal.replaceAll(',', '.');
      return sum + (double.tryParse(normalizedNominal) ?? 0.0);
    });

    // Format hasil total sebagai string
    return formatIdr(total);
  }
}
