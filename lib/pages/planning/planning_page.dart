import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/controllers/planning_controller.dart'; // Import the unified controller
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/build_total.dart';
import 'package:nextbasis_hris/widgets/expansions/build_expansion_biaya.dart';

class PlanningPage extends GetView<PlanningController> {
  const PlanningPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar(
        title: controller.biayaType == 'realisasi'
            ? 'Realisasi Biaya'
            : 'Estimasi Biaya',
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final groupedData = controller.groupedData;
            if (groupedData.isEmpty) {
              return const Center(child: Text('Tidak ada data'));
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: groupedData.entries.map((entry) {
                final categoryName = entry.key;
                final items = entry.value;

                return BuildExpansionBiaya(
                  title: Text(
                    categoryName,
                    style: TextStyle(
                      color: AppColor.textBody,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Text(
                    controller
                        .formatCurrency(items.fold<double>(0.0, (sum, item) {
                      final cleanNominal = item.nominal?.toString() ?? '0';
                      final normalizedNominal =
                          cleanNominal.replaceAll(',', '.');
                      return sum + (double.tryParse(normalizedNominal) ?? 0.0);
                    })),
                    style: TextStyle(
                      color: AppColor.textTitle,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  children: items.map((item) {
                    return GestureDetector(
                      onTap: controller.biayaType == 'realisasi'
                          ? () async {
                              final result = await Get.toNamed(
                                AppRoutes.planningEdit,
                                arguments: {
                                  'idBusinessTrip': controller.idBusinessTrip,
                                  'idItem': item.id,
                                  'biayaType': controller.biayaType,
                                  'isEditMode': true,
                                },
                              );
                              //  Get.to(
                              //   () => EditBiayaPage(
                              //     idBusinessTrip: controller.idBusinessTrip,
                              //     idItem: item.id,
                              //     biayaType: controller.biayaType,
                              //     isEditMode: true,
                              //   ),
                              // );
                              if (result != null && result) {
                                controller.updateData();
                              }
                            }
                          : null,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        dense: true,
                        title: Text(
                          '${item.keterangan}',
                          style: TextStyle(
                            color: AppColor.textBody,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Text(
                          controller
                              .formatCurrency(item.nominal?.toDouble() ?? 0.0),
                          style: TextStyle(
                            color: AppColor.textTitle,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }),
          Obx(() {
            return Align(
              alignment: Alignment.bottomCenter,
              child: BuildTotal(
                total: controller.calculateTotal(),
                onPressed: controller.biayaType == 'realisasi'
                    ? () async {
                        final result = await Get.toNamed(
                          AppRoutes.planningEdit,
                          arguments: {
                            'idBusinessTrip': controller.idBusinessTrip,
                            'biayaType': controller.biayaType,
                            'isEditMode': false,
                          },
                        );
                        if (result != null && result) {
                          controller.updateData();
                        }
                      }
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}
