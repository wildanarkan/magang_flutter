import 'package:flutter/material.dart';
import 'package:magang_flutter/widgets/build_contract_history.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class ContractHistoryPage extends StatelessWidget {
  const ContractHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: const BuildTestAppbar(
        title: 'Contract History',
      ),
      body: ListView(
      children: const [
        BuildContractHistory(),
        BuildContractHistory(),
      ],
    ),
    );
  }
}