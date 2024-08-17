import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_status.dart';
import 'package:magang_flutter/pages/estimasi_biaya_page.dart';
import 'package:magang_flutter/pages/perbandingan_biaya_page.dart';
import 'package:magang_flutter/pages/realisasi_biaya_page.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class BusinessTripDetailPage extends StatelessWidget {
  const BusinessTripDetailPage({super.key});

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
                                'PT. BELUM BUKA',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.textTitle,
                                ),
                              ),
                              Text(
                                'Surabaya',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textBody,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textBody,
                                ),
                              ),
                              AppStatus.draft(),
                            ],
                          ),
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
                                    'Sucipto',
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
                                    'Manager',
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
                                'Surabaya, IndrapuraJaya 2/1',
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
                                '30-11-2021 - 02-12-2021',
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
                              Text(
                                '0 Days',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.textTitle,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          BuildButton(
                            context: context,
                            title: 'Extend',
                            width: 88,
                            onPressed: () {},
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
                          Padding(
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
                                  'Employee 5263265367',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.textTitle),
                                ),
                              ],
                            ),
                          ),
                          Padding(
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
                                  'Employee 5263265367',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.textTitle),
                                ),
                              ],
                            ),
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
                      Get.to(() => const PerbandinganBiayaPage());
                    },
                    width: double.infinity,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    borderColor: AppColor.textBody,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
