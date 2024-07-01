import 'package:flutter/material.dart';
import 'package:magang_flutter/widgets/build_payroll_history.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class PayrollHistoryPage extends StatelessWidget {
  const PayrollHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
       appBar: const BuildTestAppbar(
        title: 'Payroll History',
      ),
    body: ListView(
      children: const [
        BuildPayrollHistory(),
        BuildPayrollHistory(),
        BuildPayrollHistory(),
        BuildPayrollHistory(),
        BuildPayrollHistory(),
        BuildPayrollHistory(),
        BuildPayrollHistory(),
      ],
    ),
    );
  }
}