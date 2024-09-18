import 'package:get/get.dart';
import 'package:magang_flutter/data/models/nominal_model.dart';
import 'package:magang_flutter/data/repo/planning_repository.dart';

class PlanningController extends GetxController {
  final PlanningRepository _planningRepository =
      Get.find<PlanningRepository>();

  final int idBusinessTrip;
  final String biayaType;

  RxBool isLoading = false.obs;
  RxMap<String, List<NominalModel>> groupedData =
      RxMap<String, List<NominalModel>>({});

  PlanningController({
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
    final result = await _planningRepository.fetchNominalData(
        idBusinessTrip, biayaType);
    groupedData.value = result;
    isLoading.value = false;
  }

  void updateData() {
    fetchNominalData(idBusinessTrip);
  }

  String formatIdr(double amount) {
    final isNegative = amount < 0;
    final absoluteValue = amount.abs();
    final formattedValue = absoluteValue
        .toStringAsFixed(2)
        .replaceAll('.', ',')
        .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
    return isNegative ? 'IDR $formattedValue-' : 'IDR $formattedValue';
  }

  String formatCurrency(double amount) {
    final isNegative = amount < 0;
    final absoluteValue = amount.abs();
    final formattedValue = absoluteValue
        .toStringAsFixed(2)
        .replaceAll('.', ',')
        .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
    return isNegative ? 'Rp $formattedValue-' : 'Rp $formattedValue';
  }

  String calculateTotal() {
    final total = groupedData.value.values
        .expand((items) => items)
        .fold<double>(0.0, (sum, item) {
      final cleanNominal = item.nominal?.toString() ?? '0';
      final normalizedNominal = cleanNominal.replaceAll(',', '.');
      return sum + (double.tryParse(normalizedNominal) ?? 0.0);
    });
    return formatIdr(total);
  }
}
