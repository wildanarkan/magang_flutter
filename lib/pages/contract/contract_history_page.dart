import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/controllers/contract_history_controller.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/items/build_item_contract.dart';
import 'package:magang_flutter/widgets/nulls/build_null_icon_text.dart';

class ContractHistoryPage extends GetView<ContractHistoryPageController> {
  const ContractHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppbar(
        title: 'Contract History',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.contracts.isEmpty) {
          return const BuildNullIconText(
            icon: Icons.block_rounded,
            text: 'Contract history not found',
            spacing: 10,
          );
        }
        return ListView.builder(
          itemCount: controller.contracts.length,
          itemBuilder: (context, index) {
            final contract = controller.contracts[index];
            return BuildItemContract(
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
