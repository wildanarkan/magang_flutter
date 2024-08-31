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
        final percentages =
            comparisonData['percentages'] as List<BusinessPercentageModel>;
        final totalNominalPlanning = comparisonData['totalNominalPlanning'];
        final totalNominalRealization =
            comparisonData['totalNominalRealization'];
        final difference = comparisonData['difference'];

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // List of Biaya Cards
                  ...percentages.map((percentage) {
                    return BuildBiayaCard(
                      title: percentage.categoryName ?? 'No Title',
                      persentase: percentage.percentage ?? '0',
                      estimasi: percentage.totalNominalPlanning ?? '0',
                      realisasi: percentage.totalNominalRealization ?? '0',
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
                        'Rp ${totalNominalPlanning ?? '0'}',
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
                        'Rp ${totalNominalRealization ?? '0'}',
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
                        'Rp ${difference ?? '0'}',
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
