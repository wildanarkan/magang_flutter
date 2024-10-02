// ignore_for_file: invalid_use_of_protected_member
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/controllers/trip_add_controller.dart';
import 'package:nextbasis_hris/controllers/trip_controller.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';
import 'package:nextbasis_hris/widgets/dropdowns/build_dropdown.dart';
import 'package:nextbasis_hris/widgets/fields/build_field_date.dart';
import 'package:nextbasis_hris/widgets/fields/build_field_text.dart';
import 'package:nextbasis_hris/widgets/items/build_item_employee.dart';

class TripAddPage extends GetView<TripAddController> {
  const TripAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppbar(title: 'Input Data'),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(AppComponent.marginPage,
                      AppComponent.marginPage, AppComponent.marginPage, 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
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
                                if (controller.selectedCompany.value !=
                                    newValue) {
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
                          Row(
                            children: [
                              Expanded(
                                child: BuildFieldDate(
                                  title: 'Start Date',
                                  dateController:
                                      controller.startDateController.value,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: BuildFieldDate(
                                  title: 'End Date',
                                  dateController:
                                      controller.endDateController.value,
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => BuildFieldText(
                              title: 'Company Address',
                              readOnly: true,
                              value: controller.address.value,
                            ),
                          ),
                          Obx(
                            () => BuildFieldText(
                              title: 'PIC',
                              readOnly: true,
                              value: controller.pic.value,
                            ),
                          ),
                          Obx(
                            () => BuildFieldText(
                              title: 'PIC Role',
                              readOnly: true,
                              value: controller.picRole.value,
                            ),
                          ),
                          Obx(
                            () => BuildFieldText(
                              title: 'PIC Phone',
                              readOnly: true,
                              value: controller.picPhone.value,
                            ),
                          ),
                          BuildFieldText(
                            title: 'Note',
                            controller: controller.noteController,
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: BuildDropdown(
                                  hint: 'SELECT EMPLOYEE',
                                  title: 'Employee',
                                  spacingDropdown:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  selectedItem:
                                      controller.selectedAllUser.value,
                                  item: controller.allUserItem.value,
                                  onChanged: (newValue) {
                                    controller.selectedAllUser.value =
                                        newValue!;
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                padding: const EdgeInsets.all(10),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  backgroundColor: AppColor.primary,
                                ),
                                onPressed: () {
                                  controller.addEmployeeToList();
                                },
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          Obx(
                            () => Column(
                              children: controller.employeeList.map((employee) {
                                return BuildItemEmployee(
                                  nameEmployee: employee.fullName!,
                                  onDelete: () {
                                    controller.removeEmployee(employee);
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(AppComponent.marginPage),
                  child: BuildButton(
                    context: context,
                    title: 'Simpan',
                    onPressed: () async {
                      // Validasi input sebelum menyimpan
                      if (controller.selectedCompany.value.isEmpty ||
                          controller.selectedCity.value.isEmpty ||
                          controller.startDateController.value.text.isEmpty ||
                          controller.endDateController.value.text.isEmpty ||
                          controller.employeeList.isEmpty) {
                        Get.snackbar(
                            'Error', 'Please fill all required fields');
                        return;
                      }

                      int? businessTripId = await controller.postBusinessTrip();
                      if (businessTripId != null) {
                        if (controller.employeeList.isNotEmpty) {
                          await controller.postTripDetail(businessTripId);
                        }
                        log('Success');
                        final tripController = Get.find<TripController>();
                        await tripController.fetchBusinessTrips();
                        Get.back(closeOverlays: true);
                        Get.snackbar(
                            'Success', 'Successfully created Business Trip');
                      } else {
                        log(businessTripId.toString());
                        Get.snackbar('Error', backgroundColor: AppColor.error, 'Failed to create Business Trip');
                      }
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
