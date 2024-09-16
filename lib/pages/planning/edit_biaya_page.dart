import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/edit_biaya_page_controller.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/buttons/build_button.dart';
import 'package:magang_flutter/widgets/dropdowns/build_dropdown.dart';
import 'package:magang_flutter/widgets/fields/build_field_text.dart';

class EditBiayaPage extends GetView<EditBiayaPageController> {
  final int idBusinessTrip;
  final int? idItem;
  final String biayaType;
  final bool isEditMode;

  const EditBiayaPage({
    super.key,
    required this.idBusinessTrip,
    this.idItem,
    this.isEditMode = false,
    required this.biayaType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar(title: isEditMode ? 'Edit Biaya' : 'Input Biaya'),
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
                            enabled: isEditMode ? false : true,
                            onChanged: (newValue) {
                              controller.updateSelectedCompany(newValue!);
                            },
                          ),
                          BuildFieldText(
                            controller: controller.keteranganController.value,
                            title: 'Note',
                            required: true,
                          ),
                          BuildFieldText(
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
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else if (controller
                                    .existingPhotoUrl.isNotEmpty) {
                                  // Tampilkan gambar dari URL jika ada
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      URLs.photoProofUrl +
                                          controller.existingPhotoUrl.value,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child; // Gambar sudah dimuat
                                        }
                                        return const SizedBox(
                                          height: 120,
                                          child: Center(
                                            child:
                                                CircularProgressIndicator(), // Tampilkan loading indikator
                                          ),
                                        );
                                      },
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
                    title: isEditMode ? 'Update' : 'Simpan',
                    onPressed: () {
                      if (isEditMode) {
                        controller.updateRealization();
                      } else {
                        if (controller.keteranganController.value.text != '' &&
                            controller.amountController.value.text != '') {
                          controller.postRealization();
                        } else {
                          Get.snackbar('Error', 'Fill your data');
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  BuildButton(
                    context: context,
                    title: 'Cancel',
                    onPressed: () {
                      Get.back(closeOverlays: true);
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
