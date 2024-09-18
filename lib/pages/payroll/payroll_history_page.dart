import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/controllers/payroll_history_controller.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/items/build_item_payroll_history.dart';
import 'package:nextbasis_hris/widgets/nulls/build_null_icon_text.dart';

class PayrollHistoryPage extends GetView<PayrollHistoryController> {
  const PayrollHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const BuildAppbar(
        title: 'Payroll History',
      ),
      body: Obx(() {
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
            final payroll = controller.payrolls[index];
            return BuildItemPayrollHistory(
              masterCategory: payroll.masterCategory ?? 'Tidak Ada Data',
              payrollDate: payroll.payrollDate ?? 'Tanggal Tidak Tersedia',
              payrollId: payroll.id.toString(), 
              onTap: () {
                print(
                    'Navigating to PayrollDetailPage with ID: ${payroll.id}');
                Get.toNamed(AppRoutes.payrollDetail,
                    parameters: {'payrollId': payroll.id.toString()});
              },
            );
          },
        );
      }),
    );
  }
}
