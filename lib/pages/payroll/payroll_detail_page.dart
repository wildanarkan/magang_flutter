import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/controllers/payroll_history_controller.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/items/build_item_payroll_detail.dart';

class PayrollDetailPage extends GetView<PayrollHistoryController> {
  final String payrollId;
  const PayrollDetailPage({super.key, required this.payrollId});

  @override
  Widget build(BuildContext context) {
    final payrollId = Get.parameters['payrollId']!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchPayrollDetail(payrollId);
    });
    return Scaffold(
      appBar: const BuildAppbar(
        title: 'Payroll Detail',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final payroll = controller.payrollDetail.value;

        if (payroll == null) {
          return const Center(child: Text('No payroll details available.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            payroll.masterCategory ?? 'No Category',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            payroll.payrollDate ?? 'No Date',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColor.textBody,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          payroll.netAmount != null ? 'Rp ${payroll.netAmount!.toString()}' : 'Rp 0',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            if (payroll.lines != null && payroll.lines!.isNotEmpty) ...[
              for (var line in payroll.lines!)
                BuildItemPayrollDetail(
                  masterCategory: line.lineMasterCategory ?? 'No Category',
                  nominal: line.nominal ?? 0,
                  note: line.note ?? 'No Note',
                ),
            ] else ...[
              const Center(child: Text('No details available.')),
            ],
          ],
        );
      }),
    );
  }
}
