import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/nominal_page_controller.dart'; // Import the unified controller
import 'package:magang_flutter/pages/edit_biaya_page.dart';
import 'package:magang_flutter/widgets/build_expansion_biaya.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_total.dart';

class NominalPage extends StatelessWidget {
  final int idBusinessTrip;
  final String biayaType; // 'realisasi' atau 'estimasi'

  const NominalPage({
    super.key,
    required this.idBusinessTrip,
    required this.biayaType,
  });

  @override
  Widget build(BuildContext context) {
    // Use the unified controller
    final NominalPageController controller = Get.put(
      NominalPageController(
        idBusinessTrip: idBusinessTrip,
        biayaType: biayaType,
      ),
    );

    return Scaffold(
      appBar: BuildTestAppbar(
        title: biayaType == 'realisasi' ? 'Realisasi Biaya' : 'Estimasi Biaya',
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final groupedData = controller.groupedData.value;
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
                      onTap: () async {
                        final result = await Get.to(() => EditBiayaPage(
                              idBusinessTrip: idBusinessTrip,
                              idItem: item.id,
                              isEditMode: true,
                            ));
                        if (result != null && result) {
                          controller.updateData();
                        }
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        dense: true,
                        title: Text(
                          '${item.keterangan}' ?? 'Tidak ada deskripsi',
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
                onPressed: biayaType == 'realisasi'
                    ? () async {
                        final result = await Get.to(() =>
                            EditBiayaPage(idBusinessTrip: idBusinessTrip));
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
