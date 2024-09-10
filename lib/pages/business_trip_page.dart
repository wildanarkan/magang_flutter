import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/business_trip_controller.dart';
import 'package:magang_flutter/pages/add_businiess_trip_page.dart';
import 'package:magang_flutter/pages/business_trip_detail_page.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_card_info.dart';
import 'package:magang_flutter/widgets/build_icon_rounded_add.dart';
import 'package:magang_flutter/widgets/build_null_safety_icon.dart';
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
            onPressed: () {
              controller.resetFilter();
              _showFilterBottomSheet(context);
            },
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.noData.value) {
            return const BuildNullSafetyIcon(
              icon: Icons.no_transfer_outlined,
              text: 'Business trip not found',
            );
          } else {
            final trips = controller.filteredBusinessTrips.isEmpty
                ? controller.businessTrips
                : controller.filteredBusinessTrips;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 120, top: 20),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return BuildCardInfo(
                  title: trip.companyName ?? 'Unknown Company',
                  subtitle: trip.cityName ?? 'Unknown City',
                  appStatus: trip.status ?? 'Unknown Status',
                  startDate: trip.startDate ?? 'Null',
                  endDate: trip.endDate ?? 'Null',
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
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter Business Trip',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Company',
                border: OutlineInputBorder(),
              ),
              items: ['All', ...controller.companyItem].map((String company) {
                return DropdownMenuItem<String>(
                  value: company,
                  child: Text(company),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedCompany.value = value!;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: ['On Progress', 'Draft', 'Completed', 'Canceled', 'All']
                  .map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedStatus.value = value!;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.startDateController.value,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        controller.selectedStartDate.value = pickedDate;
                        controller.startDateController.value.text = pickedDate
                            .toIso8601String()
                            .substring(0, 10); // Update UI
                      }
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller.endDateController.value,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        controller.selectedEndDate.value = pickedDate;
                        controller.endDateController.value.text = pickedDate
                            .toIso8601String()
                            .substring(0, 10); // Update UI
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BuildButton(
              context: context,
              onPressed: () {
                final startDate = controller.selectedStartDate.value;
                final endDate = controller.selectedEndDate.value;

                // Hanya validasi jika salah satu tanggal diisi (untuk filter tanggal)
                if ((startDate != null && endDate == null) ||
                    (startDate == null && endDate != null)) {
                  Get.snackbar('Error', 'Data tanggal harus diisi semua');
                  return;
                }

                // Clear date input fields after applying filter
                controller.startDateController.value.clear();
                controller.endDateController.value.clear();

                // Apply the filter
                controller.filterBusinessTrips();

                // Close the bottom sheet after applying the filter
                Get.back();
              },
              title: 'Apply Filter',
            ),
          ],
        ),
      ),
    );
  }
}
