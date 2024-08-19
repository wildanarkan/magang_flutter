import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/controllers/payroll_history_page_controller.dart';
import 'package:magang_flutter/pages/payroll_detail_page.dart';
import 'package:magang_flutter/widgets/build_payroll_history.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class PayrollHistoryPage extends StatelessWidget {
  const PayrollHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendefinisikan controller
    final controller = Get.put(PayrollHistoryPageController());

    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Payroll History',
      ),
      body: Obx(() {
        // Menambahkan tampilan loading jika payrolls kosong
        if (controller.payrolls.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.payrolls.length,
          itemBuilder: (context, index) {
            // Mengambil data payroll berdasarkan indeks
            final payroll = controller.payrolls[index];
            return BuildPayrollHistory(
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
