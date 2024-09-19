import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/controllers/payroll_history_controller.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/cards/build_card_date.dart';
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

        return ListView.separated(
          padding: EdgeInsets.all(AppComponent.marginPage),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: controller.payrolls.length,
          itemBuilder: (context, index) {
            final payroll = controller.payrolls[index];
            return BuildCardDate(
              title: payroll.masterCategory ?? 'Tidak Ada Data',
              startDate: payroll.payrollDate ?? 'Tanggal Tidak Tersedia',
              onTap: () {
                print('Navigating to PayrollDetailPage with ID: ${payroll.id}');
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
