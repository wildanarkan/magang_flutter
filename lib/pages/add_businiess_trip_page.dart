import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/controllers/add_businiess_trip_page_controller.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_dropdown.dart';
import 'package:magang_flutter/widgets/build_list_employee.dart';
import 'package:magang_flutter/widgets/build_pick_date.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

class AddBusiniessTripPage extends StatelessWidget {
  const AddBusiniessTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddBusiniessTripPageController());

    return Scaffold(
      appBar: const BuildTestAppbar(title: 'Input Data'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => BuildDropdown(
                        hint: 'SELECT COMPANY',
                        title: 'Company',
                        selectedItem: controller.selectedCompany.value,
                        item: controller.companyItem.value,
                        onChanged: (newValue) {
                          if (controller.selectedCompany.value != newValue) {
                            // Update company and reset city and related fields
                            controller.selectedCompany.value = newValue!;
                            controller.updateCityItems(newValue);
                            controller.clearCityRelatedData();
                          }
                        },
                      ),
                    ),
                    Obx(
                      () => BuildDropdown(
                        hint: 'SELECT CITY',
                        title: 'City',
                        selectedItem: controller.selectedCity.value,
                        item: controller.cityItem.value,
                        onChanged: (newValue) {
                          if (newValue != controller.selectedCity.value) {
                            controller.selectedCity.value = newValue!;
                            controller.updateCityRelatedData(
                              controller.selectedCompany.value,
                              newValue,
                            );
                          }
                        },
                        enabled: controller.isCityEnabled.value,
                      ),
                    ),
                    Obx(
                      () => BuildTextField(
                        title: 'Company Address',
                        readOnly: true,
                        value: controller.address.value,
                      ),
                    ),
                    Obx(
                      () => BuildTextField(
                        title: 'PIC',
                        readOnly: true,
                        value: controller.pic.value,
                      ),
                    ),
                    Obx(
                      () => BuildTextField(
                        title: 'PIC Role',
                        readOnly: true,
                        value: controller.picRole.value,
                      ),
                    ),
                    Obx(
                      () => BuildTextField(
                        title: 'PIC Phone',
                        readOnly: true,
                        value: controller.picPhone.value,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BuildPickDate(
                            title: 'Start Date',
                            dateController: controller.startDateController.value,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: BuildPickDate(
                            title: 'End Date',
                            dateController: controller.endDateController.value,
                          ),
                        ),
                      ],
                    ),
                    BuildDropdown(
                      hint: 'SELECT DEPARTURE',
                      title: 'Departure From',
                      selectedItem: controller.selectedAllCity.value,
                      item: controller.allCityItem.value,
                      onChanged: (newValue) {
                        controller.selectedAllCity.value = newValue!;
                      },
                    ),
                    BuildDropdown(
                      hint: 'SELECT EMPLOYEE',
                      title: 'Employee',
                      selectedItem: controller.selectedAllUser.value,
                      item: controller.allUserItem.value,
                      onChanged: (newValue) {
                        controller.selectedAllUser.value = newValue!;
                      },
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: BuildButton(
                        context: context,
                        title: 'Add Employee',
                        width: 131,
                        onPressed: () {},
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                    const BuildListEmployee(
                      nameEmployee: 'Employee 121029102',
                    ),
                    const BuildListEmployee(
                      nameEmployee: 'Employee 928329839',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: BuildButton(
              context: context,
              title: 'Simpan',
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
