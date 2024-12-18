import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/controllers/planning_comparison_controller.dart';
import 'package:nextbasis_hris/data/models/business_percentage_model.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart'; // Import BuildAppbar
import 'package:nextbasis_hris/widgets/build_widget_between.dart'; // Import BuildWidgetBetween
import 'package:nextbasis_hris/widgets/cards/build_card_cost.dart';

class PlanningComparisonPage extends GetView<PlanningComparisonController> {
  final int idBusinessTrip;

  PlanningComparisonPage({super.key, required this.idBusinessTrip}) {
    controller.fetchComparisonData(idBusinessTrip);
  }

  String formatCurrency(String amount) {
    final normalizedAmount = amount.replaceAll('.', '').replaceAll(',', '.');
    final doubleAmount = double.tryParse(normalizedAmount) ?? 0.0;
    final isNegative = doubleAmount < 0;
    final absoluteValue = doubleAmount.abs();
    final formattedValue = absoluteValue
        .toStringAsFixed(2)
        .replaceAll('.', ',')
        .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
    return isNegative ? '- Rp $formattedValue' : 'Rp $formattedValue';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppbar(
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
                padding: EdgeInsets.all(AppComponent.marginPage),
                children: [
                  ...percentages.map((percentage) {
                    final estimasi =
                        formatCurrency(percentage.totalNominalPlanning ?? '0');
                    final realisasi = formatCurrency(
                        percentage.totalNominalRealization ?? '0');

                    return BuildCardCost(
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
