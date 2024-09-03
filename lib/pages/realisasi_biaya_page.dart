import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/realisasi_biaya_page_controller.dart';
import 'package:magang_flutter/pages/edit_biaya_page.dart';
import 'package:magang_flutter/widgets/build_expansion_biaya.dart';
import 'package:magang_flutter/widgets/build_total.dart';

class RealisasiBiayaPage extends StatelessWidget {
  final int idBusinessTrip; // Tambahkan parameter untuk ID business trip

  const RealisasiBiayaPage({super.key, required this.idBusinessTrip});

  @override
  Widget build(BuildContext context) {
    final RealisasiBiayaPageController controller =
        Get.put(RealisasiBiayaPageController(idBusinessTrip: idBusinessTrip));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Realisasi Biaya'),
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final groupedData = controller.groupedData.value;
            print('Grouped Data in UI: $groupedData'); // Log data in UI

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
                    'Rp ${items.fold(0.0, (sum, item) {
                          final cleanNominal = item.nominal?.toString() ?? '0';
                          final normalizedNominal =
                              cleanNominal.replaceAll(',', '.');
                          return sum +
                              (double.tryParse(normalizedNominal) ?? 0.0);
                        }).toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                      color: AppColor.textTitle,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  children: items.map((item) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      title: Text(
                        item.keterangan ?? 'Tidak ada deskripsi',
                        style: TextStyle(
                          color: AppColor.textBody,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Text(
                        'Rp ${item.nominal ?? '0'}',
                        style: TextStyle(
                          color: AppColor.textTitle,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
                onPressed: () async {
                  final result = await Get.to(
                      () => EditBiayaPage(idBusinessTrip: idBusinessTrip));
                  if (result != null && result) {
                    controller
                        .updateData(); // Memanggil updateData untuk mendapatkan data terbaru
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
