import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_status.dart';
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/business_trip_detail_page_controller.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';
import 'package:magang_flutter/pages/estimasi_biaya_page.dart';
import 'package:magang_flutter/pages/perbandingan_biaya_page.dart';
import 'package:magang_flutter/pages/realisasi_biaya_page.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_row_text_icon.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class BusinessTripDetailPage extends StatelessWidget {
  final BusinessTripDetailPageController controller =
      Get.put(BusinessTripDetailPageController());

  final BusinessTripModel trip;
  final String? status;

  BusinessTripDetailPage({super.key, required this.trip, this.status}) {
    controller.setInitialVariable(
        trip.extendDay ?? 0,
        trip.photoDocument ??
            'No photo document'); // Inisialisasi nilai extendDay
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildTestAppbar(
        title: 'Business Trip Detail',
        actions: [
          Icon(
            Icons.star_rounded,
            size: 32,
            color: AppColor.primary,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 170),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trip.companyName ?? 'Unknown Company',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.textTitle,
                                ),
                              ),
                              Text(
                                trip.cityName ?? 'Unknown City',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textBody,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (status == 'Draft') AppStatus.draft(),
                          if (status == 'On Progress') AppStatus.onProgress(),
                          if (status == 'Completed')
                            AppStatus.complete('Completed'),
                          if (status == 'Canceled')
                            AppStatus.canceled('Canceled'),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                size: 18,
                                color: AppColor.textTitle,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PIC',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textBody,
                                    ),
                                  ),
                                  Text(
                                    trip.pic ?? 'Unknown PIC',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textTitle,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PIC Role',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textBody,
                                    ),
                                  ),
                                  Text(
                                    trip.picRole ?? 'Unknown Role',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.textTitle),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BuildRowTextIcon(
                        icons: Icons.location_on_rounded,
                        title: 'City, Address',
                        subtitle:
                            '${trip.cityName}, ${trip.companyAddress ?? 'Unknown Address'}',
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BuildRowTextIcon(
                        title: 'Departure from',
                        subtitle: trip.departureFrom ?? 'Null',
                        icons: Icons.location_city,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BuildRowTextIcon(
                        title: 'Date',
                        subtitle: '${trip.startDate} - ${trip.endDate}',
                        icons: Icons.access_time_filled_outlined,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BuildRowTextIcon(
                        title: 'Note',
                        subtitle: '${trip.note}',
                        icons: Icons.my_library_books_rounded,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Employee List',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.textBody),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ...trip.users?.map((user) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: AppColor.primary,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        user.fullName ?? 'Unknown Employee',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.textTitle),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList() ??
                              [const Text('No employees')],
                        ],
                      ),
                      Row(
                        children: [
                          Obx(() {
                            return GestureDetector(
                              onTap: () async {
                                final fullUrl =
                                    '${URLs.photoDocumentUrl}${controller.photoDocument.value}';
                                await controller.showFileDialog(context, fullUrl);
                              },
                              child: Text(
                                controller.photoDocument.value,
                                style: TextStyle(
                                  color: AppColor.textTitle,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            );
                          }),
                          IconButton(
                            icon: const Icon(Icons.attach_file),
                            onPressed: () async {
                              // Pilih file dari file manager
                              final result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'jpeg',
                                  'png',
                                  'pdf'
                                ],
                              );

                              if (result != null &&
                                  result.files.single.path != null) {
                                final selectedFile =
                                    File(result.files.single.path!);
                                final extension = selectedFile.path
                                    .split('.')
                                    .last
                                    .toLowerCase();

                                if (['jpg', 'jpeg', 'png', 'pdf']
                                    .contains(extension)) {
                                  // Tampilkan konfirmasi untuk update file
                                  Get.defaultDialog(
                                    title: 'Confirm Update',
                                    middleText:
                                        'Are you sure you want to update with this file?',
                                    textCancel: 'Cancel',
                                    textConfirm: 'Update',
                                    onConfirm: () {
                                      log(extension);
                                      log('${selectedFile}1');
                                      controller.updateFileInDatabase(
                                          selectedFile,
                                          trip.idBusinessTrip ?? 0);
                                      log('${trip.photoDocument}2');
                                    },
                                  );
                                } else {
                                  // Tampilkan pesan error jika file tidak valid
                                  Get.defaultDialog(
                                    title: 'Invalid File',
                                    middleText:
                                        'Please select a valid jpg, jpeg, png, or pdf file.',
                                    textConfirm: 'OK',
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: BuildButton(
                          context: context,
                          title: 'Perkiraan',
                          onPressed: () {
                            Get.to(() => EstimasiBiayaPage(
                                idBusinessTrip: trip.idBusinessTrip ?? 0));
                          },
                        ),
                      ),
                      const SizedBox(width: 17),
                      Expanded(
                        child: BuildButton(
                          context: context,
                          title: 'Realisasi',
                          onPressed: () {
                            Get.to(() => RealisasiBiayaPage(
                                idBusinessTrip: trip.idBusinessTrip ?? 0));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  BuildButton(
                    context: context,
                    title: 'Perbandingan',
                    onPressed: () {
                      Get.to(() => PerbandinganBiayaPage(
                          idBusinessTrip: trip.idBusinessTrip ?? 0));
                    },
                    width: double.infinity,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    borderColor: AppColor.textBody,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
