import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/controllers/balance_detail_controller.dart';
import 'package:nextbasis_hris/pages/balance/balance_sheet_detail_page.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/build_widget_between.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button_rounded.dart';

class BalanceDetailPage extends StatelessWidget {
  const BalanceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BalanceDetailController());
    
    return Scaffold(
      appBar: BuildAppbar(
        title: 'Balance Detail',
        actions: [
          BuildButtonRounded(
            rounded: 9,
            size: 10,
            padding: 5,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
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
                      const Text(
                        'Uang Harian',
                        style: TextStyle(
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
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: BuildWidgetBetween(
                    padding: const EdgeInsets.all(10),
                    leftWidget: Text(
                      controller.formattedDate.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    rightWidget: Text(
                      'Rp 120.000,00',
                      style: TextStyle(color: AppColor.complete),
                    ),
                    onTap: () {
                     
                      Get.to(() => const BalanceSheetDetailPage());
                        
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SingleChildScrollView(
            child: Padding(
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
                    leftWidget: Text(
                      controller.formattedDate.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                       Get.to(() => const BalanceSheetDetailPage());
                    },
                    rightWidget: Text(
                      'Rp 80.000,00',
                      style: TextStyle(color: AppColor.complete),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SingleChildScrollView(
            child: Padding(
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
                    leftWidget: Text(
                      controller.formattedDate.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    rightWidget: Text(
                      'Rp 260.000,00',
                      style: TextStyle(color: AppColor.complete),
                    ),
                    onTap: () {
                      Get.to(() => const BalanceSheetDetailPage());
                    },
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
