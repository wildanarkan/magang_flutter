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
        return ListView.builder(
          itemCount: controller.payrolls.length,
          itemBuilder: (context, index) {
            final payroll = controller.payrolls[index];
            return BuildPayrollHistory(
              masterCategory: payroll['master_category'] ?? 'No Data',
              payrollDate: payroll['payroll_date'] ?? 'No Date Available',
              onTap: () {
                Get.to(() => const PayrollDetailPage());
              },
            );
          },
        );
      }),
    );
  }
}
