import 'package:cached_network_image/cached_network_image.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/home_page_controller.dart';
import 'package:magang_flutter/pages/business%20trip/business_trip_detail_page.dart';
import 'package:magang_flutter/widgets/cards/build_card_info.dart';
import 'package:magang_flutter/widgets/dialogs/build_dialog_confirmation.dart';
import 'package:magang_flutter/widgets/expansions/build_expansion_tile.dart';
import 'package:magang_flutter/widgets/nulls/build_null_icon_text.dart';
import 'package:magang_flutter/widgets/texts/build_text_link.dart';

import '../controllers/navigator_page_controllers.dart';

class HomePage extends GetView<NavigatorPageControllers> {
  final HomePageController homePageController = Get.find<HomePageController>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate dx and dy to position the FAB in the center of the bottom-right corner
    final dx = screenWidth - 50; // 20 is the margin from the right edge
    final dy =
        screenHeight / 2 - 25; // 45 is half the height of the FAB (90 / 2)
    return FloatingDraggableWidget(
      floatingWidget: Obx(
        () => FloatingActionButton(
          onPressed: homePageController.isLoading.value
              ? null
              : () {
                  Get.dialog(
                    BuildDialogConfirmation(
                      title: "Are you sure?",
                      message: "Do you really want to check in/out?",
                      onCancel: () {
                        Get.back(closeOverlays: true);
                      },
                      onConfirm: () {
                        Get.back(closeOverlays: true);
                        homePageController.checkInOut();
                      },
                    ),
                  );
                },
          backgroundColor: homePageController.isLoading.value
              ? Colors.white
              : AppColor.primary,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: homePageController.isLoading.value
              ? CircularProgressIndicator(
                  color: AppColor.primary,
                )
              : const Icon(
                  Icons.fingerprint,
                  size: 35,
                  color: Colors.white,
                ),
        ),
      ),
      floatingWidgetHeight: 50,
      floatingWidgetWidth: 50,
      autoAlign: true,
      dx: dx,
      dy: dy,
      mainScreenWidget: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/blue_background.png'),
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            ListView(
              padding: const EdgeInsets.only(
                  top: 25, bottom: 120, left: 25, right: 25),
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 25),
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                buildCardProfile(context),
                const SizedBox(
                  height: 15,
                ),
                buildCurrentBusiness(context),
                const SizedBox(
                  height: 15,
                ),
                buildSaveCollapse(context),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // BUILD WIDGET
  Container buildCurrentBusiness(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: BuildExpansionTile(
        childrenPadding: const EdgeInsets.all(0),
        tilePadding: EdgeInsets.zero,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        initiallyExpanded: false,
        title: Text(
          'Current Business Trip',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.textBody,
          ),
        ),
        children: [
          Obx(() {
            if (homePageController.isLoading.value) {
              return const SizedBox(
                  height: 80,
                  child: Center(child: CircularProgressIndicator()));
            } else if (homePageController.currentBusinessTrip.isEmpty) {
              return const BuildNullIconText(
                icon: Icons.no_transfer_outlined,
                iconSize: 50,
                text: 'Business trip not found',
                textSize: 12,
                padding: EdgeInsets.symmetric(vertical: 20),
              );
            } else {
              final trips = homePageController.currentBusinessTrip;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];
                  return BuildCardInfo(
                    title: trip.companyName ?? 'Unknown Company',
                    subtitle: trip.cityName ?? 'Unknown City',
                    appStatus: trip.status ?? 'Unknown Status',
                    startDate: trip.startDate ?? 'Null',
                    endDate: trip.endDate ?? 'Null',
                    useContainer: false,
                    onTap: () {
                      Get.to(
                        () => BusinessTripDetailPage(
                          trip: trip,
                          status: trip.status,
                        ),
                      );
                    },
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }

  Widget buildSaveCollapse(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: BuildExpansionTile(
        childrenPadding: const EdgeInsets.all(0),
        tilePadding: EdgeInsets.zero,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        initiallyExpanded: false,
        title: Text(
          'Save Business Trip',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.textBody,
          ),
        ),
        children: [
          BuildTextLink(
            title: 'View All',
            context: context,
            onTap: () {
              controller.changePage(1);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            // Cek apakah savedBusinessTrips kosong
            if (homePageController.savedBusinessTrips.isEmpty) {
              return const BuildNullIconText(
                icon: Icons.no_transfer_outlined,
                iconSize: 50,
                text: "You don't have any saved business trip",
                textSize: 12,
                padding: EdgeInsets.symmetric(vertical: 20),
              );
            } else {
              return Column(
                children: homePageController.savedBusinessTrips.map((trip) {
                  return BuildCardInfo(
                    title: trip.companyName ?? 'Unknown Company',
                    subtitle: trip.cityName ?? 'Unknown City',
                    appStatus: trip.status ?? 'Unknown Status',
                    startDate: trip.startDate ?? '0000-00-00',
                    endDate: trip.endDate ?? '0000-00-00',
                    onTap: () {
                      Get.to(
                        () => BusinessTripDetailPage(
                          trip: trip,
                          status: trip.status,
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget buildCardProfile(BuildContext context) {
    // final ProfilePageController profileController =
    //   Get.find<ProfilePageController>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Obx(
                    () => CachedNetworkImage(
                      height: 40,
                      width: 40,
                      imageUrl:
                          '${URLs.photoUrl}${controller.profilePhotoUrl.value}',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        '${controller.firstName.value} ${controller.lastName.value}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColor.textTitle,
                        ),
                      );
                    }),
                    Obx(
                      () => Text(
                        controller.role.value,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.textBody,
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    BuildTextLink(
                      title: 'Go To Profile',
                      context: context,
                      onTap: () {
                        controller.changePage(3);
                      },
                    ),
                    const Text(
                      ' ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(),
            ),
            Text(
              'Your Attendance Today',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColor.textBody,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_filled,
                        size: 36,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Time',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textBody,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Obx(() {
                            return Text(
                              homePageController.startTime.value,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColor.textTitle,
                              ),
                            );
                          })
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        size: 36,
                        color: Colors.red[300],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Time',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textBody,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Obx(() {
                            return Text(
                              homePageController.endTime.value,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColor.textTitle,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
