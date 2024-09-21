import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/controllers/leave_add_controller.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';
import 'package:nextbasis_hris/widgets/dropdowns/build_dropdown.dart';
import 'package:nextbasis_hris/widgets/fields/build_field_date.dart';
import 'package:nextbasis_hris/widgets/fields/build_field_text.dart';

class LeaveAddPage extends GetView<LeaveAddController> {
  const LeaveAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppbar(title: 'Form Ask to Leave'),
      resizeToAvoidBottomInset: true,
      body: Obx(() {
        if (controller.leaveCategoryItem.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.all(AppComponent.marginPage),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            BuildDropdown(
                              hint: 'Select',
                              title: 'Leave Category',
                              selectedItem: controller.selectedCategory.value,
                              item: controller.leaveCategoryItem,
                              onChanged: (newValue) {
                                controller.selectedCategory.value = newValue!;
                                controller.updateSelectedLimit(newValue);
                              },
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Limit:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    ' ${controller.selectedLimit.value}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            BuildFieldText(
                              controller:
                                  controller.reasonForLeaveController.value,
                              title: 'Reason For Leave',
                              hintText: 'Holiday',
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: BuildFieldDate(
                                    title: 'Start Leave Date',
                                    dateController:
                                        controller.startDateController.value,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: BuildFieldDate(
                                    title: 'End Leave Date',
                                    dateController:
                                        controller.endDateController.value,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BuildButton(
                context: context,
                title: 'Simpan',
                width: 320,
                onPressed: () async {
                  await controller.makeLeave();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
