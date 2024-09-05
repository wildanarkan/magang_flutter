import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/perbandingan_biaya_page_controller.dart';
import 'package:magang_flutter/data/models/business_percentage_model.dart';
import 'package:magang_flutter/widgets/build_biaya_card.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart'; // Import BuildTestAppbar
import 'package:magang_flutter/widgets/build_widget_between.dart'; // Import BuildWidgetBetween

class PerbandinganBiayaPage extends StatelessWidget {
  final PerbandinganBiayaPageController controller =
      Get.put(PerbandinganBiayaPageController());
  final int idBusinessTrip;

  PerbandinganBiayaPage({super.key, required this.idBusinessTrip}) {
    // Fetch data saat halaman diinisialisasi
    controller.fetchComparisonData(idBusinessTrip);
  }

  String formatCurrency(String amount) {
    // Hapus pemisah ribuan dan ganti koma desimal dengan titik
    final normalizedAmount = amount.replaceAll('.', '').replaceAll(',', '.');

    // Konversi string menjadi double
    final doubleAmount = double.tryParse(normalizedAmount) ?? 0.0;

    // Periksa apakah nilai tersebut negatif
    final isNegative = doubleAmount < 0;

    // Ambil nilai absolut dari angka
    final absoluteValue = doubleAmount.abs();

    // Format angka dengan dua desimal dan titik sebagai pemisah ribuan
    final formattedValue = absoluteValue
        .toStringAsFixed(2)
        .replaceAll('.', ',') // Ganti titik desimal dengan koma
        .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'),
            '.'); // Tambahkan titik sebagai pemisah ribuan

    // Kembalikan nilai dengan "Rp" di depan dan tanda minus di belakang jika negatif
    return isNegative ? '- Rp $formattedValue' : 'Rp $formattedValue';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Perbandingan Biaya',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final comparisonData = controller.getComparisonData();
        final List<BusinessPercentageModel> percentages =
            (comparisonData['percentages'] as List<dynamic>)
                .map((data) => BusinessPercentageModel.fromJson(data))
                .toList();

        final totalNominalPlanning =
            comparisonData['totalNominalPlanning'] as String;
        final totalNominalRealization =
            comparisonData['totalNominalRealization'] as String;
        final difference = comparisonData['difference'] as String;

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ...percentages.map((percentage) {
                    final estimasi =
                        formatCurrency(percentage.totalNominalPlanning ?? '0');
                    final realisasi = formatCurrency(
                        percentage.totalNominalRealization ?? '0');

                    return BuildBiayaCard(
                      title: percentage.categoryName ?? 'No Title',
                      persentase: percentage.percentage ?? '0',
                      estimasi: estimasi,
                      realisasi: realisasi,
                      minusPersentase: (percentage.percentage != null &&
                          percentage.percentage!.startsWith('-')),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Card(
              elevation: 10,
              color: Colors.white,
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildWidgetBetween(
                      leftWidget: Text(
                        'Total Estimasi',
                        style: TextStyle(
                          color: AppColor.textTitle,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      rightWidget: Text(
                        formatCurrency(totalNominalPlanning),
                        style: TextStyle(
                          color: AppColor.textTitle,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    BuildWidgetBetween(
                      leftWidget: Text(
                        'Total Realisasi',
                        style: TextStyle(
                          color: AppColor.textTitle,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      rightWidget: Text(
                        formatCurrency(totalNominalRealization),
                        style: TextStyle(
                          color: AppColor.textTitle,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    BuildWidgetBetween(
                      leftWidget: Text(
                        'Perbedaan Biaya',
                        style: TextStyle(
                          color: AppColor.textTitle,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      rightWidget: Text(
                        formatCurrency(difference),
                        style: TextStyle(
                          color: AppColor.textTitle,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
