import 'package:get/get.dart';
import 'package:nextbasis_hris/data/models/business_calculate_model.dart';
import 'package:nextbasis_hris/data/models/business_percentage_model.dart';
import 'package:nextbasis_hris/data/repo/planning_repository.dart';

class PlanningComparisonController extends GetxController {
  final PlanningRepository _planningRepository = PlanningRepository();

  RxList<BusinessPercentageModel> percentages = <BusinessPercentageModel>[].obs;
  Rx<BusinessCalculateModel?> calculation = Rx<BusinessCalculateModel?>(null);
  RxBool isLoading = false.obs;

  Future<void> fetchComparisonData(int idBusinessTrip) async {
    isLoading.value = true;
    final result =
        await _planningRepository.fetchPlanningComparison(idBusinessTrip);
    if (result.isNotEmpty) {
      percentages.value = result['percentages'] ?? [];
      calculation.value = result['calculation'];
    }
    isLoading.value = false;
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
