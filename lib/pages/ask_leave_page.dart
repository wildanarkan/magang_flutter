import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/ask_leave_page_controller.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_dropdown.dart';
import 'package:magang_flutter/widgets/build_pick_date.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

class AskLeavePage extends StatelessWidget{
  const AskLeavePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AskLeavePageController());

    return Scaffold(
      appBar: const BuildTestAppbar(title: 'Form Ask to Leave'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leave Category',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColor.textBody,
                        ),
                      ),
                      BuildDropdown(
                        hint: 'Select',
                        title: '',
                        selectedItem: controller.selectedCompany.value,
                        item: controller.companyItem,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Limit:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            ' 10 days',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const BuildTextField(
                        title: 'Reason For Leave',
                        hintText: 'Holiday',
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BuildPickDate(
                              title: 'Start Leave Date',
                              dateController: controller.startDateController.value,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: BuildPickDate(
                              title: 'End Leave Date',
                              dateController: controller.endDateController.value,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: BuildButton(
              context: context,
              title: 'Simpan',
              width: 320,
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
