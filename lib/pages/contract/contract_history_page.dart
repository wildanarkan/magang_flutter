import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/controllers/contract_history_controller.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/cards/build_card_date.dart';
import 'package:nextbasis_hris/widgets/nulls/build_null_icon_text.dart';

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
          padding: EdgeInsets.all(AppComponent.marginPage),
          itemCount: controller.contracts.length,
          itemBuilder: (context, index) {
            final contract = controller.contracts[index];
            return BuildCardDate(
              title: contract['status'] ?? 'No Data',
              startDate: contract['start_date'] ?? 'No Data',
              endDate: contract['end_date'] ?? 'No Data',
            );
          },
        );
      }),
    );
  }
}
