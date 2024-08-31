import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_status.dart';
import 'package:magang_flutter/controllers/business_trip_detail_page_controller.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';
import 'package:magang_flutter/pages/estimasi_biaya_page.dart';
import 'package:magang_flutter/pages/perbandingan_biaya_page.dart';
import 'package:magang_flutter/pages/realisasi_biaya_page.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

class BusinessTripDetailPage extends StatelessWidget {
  final BusinessTripDetailPageController controller =
      Get.put(BusinessTripDetailPageController());

  final BusinessTripModel trip;
  final String? status;

   BusinessTripDetailPage({super.key, required this.trip, this.status}) {
    controller.setInitialExtendDay(trip.extendDay ?? 0); // Inisialisasi nilai extendDay
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
            padding: const EdgeInsets.only(bottom: 80),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
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
                                'City, Address',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textBody,
                                ),
                              ),
                              Text(
                                '${trip.cityName}, ${trip.companyAddress ?? 'Unknown Address'}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textTitle),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_city,
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
                                'Departure from',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textBody,
                                ),
                              ),
                              Text(
                                trip.departureFrom ?? 'Null',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textTitle),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time_filled_outlined,
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
                                'Date',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textBody,
                                ),
                              ),
                              Text(
                                '${trip.startDate} - ${trip.endDate}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textTitle),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Extended',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textBody,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Obx(() => Text(
                                '${controller.extendDay.value} Days', // Observe nilai extendDay
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.textTitle,
                                ),
                              )),
                            ],
                          ),
                          const Spacer(),
                          BuildButton(
                            context: context,
                            title: 'Extend',
                            width: 88,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Extended'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        BuildTextField(
                                          inputType: TextInputType.number,
                                          controller: controller
                                              .extendedController.value,
                                          title: 'Extend Days',
                                          hintText: 'Enter number of days',
                                          onChanged: (value) {
                                            controller.extendedController.value
                                                .text = value;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        BuildButton(
                                          context: context,
                                          title: 'Simpan',
                                          onPressed: () {
                                            final extendDayValue = int.tryParse(
                                                controller.extendedController
                                                    .value.text);
                                            if (extendDayValue != null) {
                                              controller.updateExtendedDay(
                                                  trip.idBusinessTrip!,
                                                  extendDayValue);
                                            } else {
                                              Get.snackbar('Error',
                                                  'Please enter a valid number of days');
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
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
                            Get.to(() => const EstimasiBiayaPage());
                          },
                        ),
                      ),
                      const SizedBox(width: 17),
                      Expanded(
                        child: BuildButton(
                          context: context,
                          title: 'Realisasi',
                          onPressed: () {
                            Get.to(() => const RealisasiBiayaPage());
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
