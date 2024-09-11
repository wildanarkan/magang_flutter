import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/controllers/payroll_history_page_controller.dart';
import 'package:magang_flutter/pages/payroll/payroll_detail_page.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/items/build_item_payroll_history.dart';
import 'package:magang_flutter/widgets/nulls/build_null_icon_text.dart';

class PayrollHistoryPage extends StatelessWidget {
  const PayrollHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendefinisikan controller
    final controller = Get.put(PayrollHistoryPageController());

    return Scaffold(
      appBar: const BuildAppbar(
        title: 'Payroll History',
      ),
      body: Obx(() {
        // Menambahkan tampilan loading jika payrolls kosong
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.payrolls.isEmpty) {
          return const BuildNullIconText(
            icon: Icons.block_rounded,
            spacing: 10,
            text: 'Payroll History not found',
          );
        }

        return ListView.builder(
          itemCount: controller.payrolls.length,
          itemBuilder: (context, index) {
            // Mengambil data payroll berdasarkan indeks
            final payroll = controller.payrolls[index];
            return BuildItemPayrollHistory(
              masterCategory: payroll.masterCategory ?? 'Tidak Ada Data',
              payrollDate: payroll.payrollDate ?? 'Tanggal Tidak Tersedia',
              payrollId: payroll.id.toString(), // Mengirimkan ID payroll
              onTap: () {
                print(
                    'Navigating to PayrollDetailPage with ID: ${payroll.id}'); // Debug print
                Get.to(
                    () => PayrollDetailPage(payrollId: payroll.id.toString()));
              },
            );
          },
        );
      }),
    );
  }
}
