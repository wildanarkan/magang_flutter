import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/controllers/add_businiess_trip_page_controller.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_dropdown.dart';
import 'package:magang_flutter/widgets/build_list_employee.dart';
import 'package:magang_flutter/widgets/build_pick_date.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

class AddBusiniessTripPage extends  GetView<AddBusiniessTripPageController> {
  const AddBusiniessTripPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    BuildDropdown(
                      hint: 'Select',
                      title: 'Company',
                      selectedItem: controller.selectedCompany.value,
                      item: controller.companyItem,
                    ),
                    BuildDropdown(
                      hint: 'Select',
                      title: 'City',
                      selectedItem: controller.selectedCompany.value,
                      item: controller.companyItem,
                    ),
                    const BuildTextField(
                      title: 'Company Address',
                      required: false,
                    ),
                    BuildPickDate(
                      title: 'Pick Date',
                      dateController: controller.dateController.value,
                    ),
                    const BuildTextField(
                      title: 'Departing From',
                      required: true,
                    ),
                    const BuildTextField(
                      title: 'PIC',
                      required: true,
                    ),
                    const BuildTextField(
                      title: 'PIC Role',
                      required: true,
                    ),
                    BuildDropdown(
                      selectedItem: controller.selectedCompany.value,
                      item: controller.companyItem,
                      hint: 'Ga Guna',
                      title: 'Employee',
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
