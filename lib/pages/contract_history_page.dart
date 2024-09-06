import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/controllers/contract_history_page_controller.dart';
import 'package:magang_flutter/widgets/build_contract_history.dart';
import 'package:magang_flutter/widgets/build_null_safety_icon.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class ContractHistoryPage extends StatelessWidget {
  const ContractHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContractHistoryPageController controller =
        Get.put(ContractHistoryPageController());

    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Contract History',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.contracts.isEmpty) {
          return const BuildNullSafetyIcon(
            icon: Icons.block_rounded,
            text: 'Contract history not found',
            spacing: 10,
          );
        }
        return ListView.builder(
          itemCount: controller.contracts.length,
          itemBuilder: (context, index) {
            final contract = controller.contracts[index];
            return BuildContractHistory(
              text: contract['status'] ?? 'No Data',
              start_date: contract['start_date'] ?? 'No Data',
              end_date: contract['end_date'] ?? 'No Data',
            );
          },
        );
      }),
    );
  }
}
