import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_widget_between.dart';

class BalanceSheetDetailPage extends StatelessWidget {
  const BalanceSheetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('EEEE, d-MM-yyyy').format(now);

    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Balance Sheet',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24,24,24,0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Rp.460.000,00',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textBody,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BuildWidgetBetween(
                  padding: const EdgeInsets.all(10),
                  leftWidget: const Text(
                    'Makan Siang',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  rightWidget: Text(
                    '-Rp 25.000,00',
                    style: TextStyle(color: AppColor.decline),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BuildWidgetBetween(
                  padding: const EdgeInsets.all(10),
                  leftWidget: const Text(
                    'Makan Pagi',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  rightWidget: Text(
                    '-Rp 15.000,00',
                    style: TextStyle(color: AppColor.decline),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BuildWidgetBetween(
                  padding: const EdgeInsets.all(10),
                  leftWidget: const Text(
                    'Deposit Awal',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  rightWidget: Text(
                    'Rp 500.000,00',
                    style: TextStyle(color: AppColor.complete),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
