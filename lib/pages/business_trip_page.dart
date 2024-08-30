import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/business_trip_controller.dart';
import 'package:magang_flutter/pages/add_businiess_trip_page.dart';
import 'package:magang_flutter/pages/business_trip_detail_page.dart';
import 'package:magang_flutter/widgets/build_card_info.dart';
import 'package:magang_flutter/widgets/build_icon_rounded_add.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class BusinessTripPage extends StatelessWidget {
  final BusinessTripController controller = Get.put(BusinessTripController());

   BusinessTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildTestAppbar(
        paddingTitle: const EdgeInsets.only(left: 20),
        title: 'Business Trip',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_alt_rounded,
              size: 24,
            ),
            color: AppColor.primary,
          ),
          BuildIconRoundedAdd(
            rounded: 9,
            size: 10,
            padding: 5,
            onPressed: () {
              Get.to(() => const AddBusiniessTripPage());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 120, top: 20),
              itemCount: controller.businessTrips.length,
              itemBuilder: (context, index) {
                final trip = controller.businessTrips[index];
                return BuildCardInfo(
                  title: trip.companyName ?? 'Unknown Company',
                  subtitle: trip.cityName ?? 'Unknown City',
                  appStatus: trip.status ?? 'Unknown Status',
                  startDate: trip.startDate ?? 'Null',
                  endDate: trip.endDate ?? 'Null',
                  onTap: () {
                    Get.to(() => BusinessTripDetailPage(trip: trip, status: trip.status,));
                  },
                );
              },
            );
          }
        }),
      ),
    );
  }
}

