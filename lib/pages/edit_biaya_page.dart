import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/edit_biaya_page_controller.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_dropdown.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

class EditBiayaPage extends StatelessWidget {
  final int idBusinessTrip;

  const EditBiayaPage({super.key, required this.idBusinessTrip});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(EditBiayaPageController(idBusinessTrip: idBusinessTrip));

    return Scaffold(
      appBar: const BuildTestAppbar(title: 'Edit Biaya'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuildDropdown(
                            hint: 'Select',
                            title: 'Category',
                            selectedItem: controller.selectedCompany.value,
                            item: controller.companyItem,
                            onChanged: (newValue) {
                              controller.updateSelectedCompany(newValue!);
                            },
                          ),
                          BuildTextField(
                            controller: controller.keteranganController.value,
                            title: 'Note',
                            required: true,
                          ),
                          BuildTextField(
                            controller: controller.amountController.value,
                            title: 'Amount',
                            required: true,
                            inputType: TextInputType.number,
                          ),
                          Text(
                            'Upload Photo',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textBody,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: GestureDetector(
                              onTap: controller.getImageGallery,
                              child: Obx(() {
                                if (controller.images.isNotEmpty) {
                                  final image = controller.images.last;
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      image,
                                      height: 129,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else {
                                  return DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(12),
                                    dashPattern: const [5],
                                    strokeWidth: 1,
                                    color: AppColor.textBody,
                                    padding: const EdgeInsets.all(6),
                                    child: SizedBox(
                                      height: 129,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image,
                                            size: 40,
                                            color: AppColor.textBody,
                                          ),
                                          Text(
                                            'Upload Photo',
                                            style: TextStyle(
                                              color: AppColor.textBody,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColor.textBody,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  BuildButton(
                    context: context,
                    title: 'Update',
                    onPressed: () {
                      controller.submitEditBiaya();
                    },
                  ),
                  const SizedBox(height: 16),
                  BuildButton(
                    context: context,
                    title: 'Cancel',
                    onPressed: () {
                      Get.back();
                    },
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    borderColor: AppColor.textBody,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
