import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_routes.dart';
import 'package:magang_flutter/controllers/leave_history_page_controller.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/buttons/build_button.dart';
import 'package:magang_flutter/widgets/cards/build_card_info.dart';
import 'package:magang_flutter/widgets/nulls/build_null_icon_text.dart';

class LeaveHistoryPage extends GetView<LeaveHistoryPageController> {
  const LeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nip = Get.arguments?['nip'] ?? Get.arguments;
    log('ini adalah nip$nip');

    if (nip == Get.arguments['nip']) {
      controller.filterByNip(nip);
    }

    return Scaffold(
      appBar: BuildAppbar(
        title: Get.arguments['pendingPage'] ? 'Leave Request' : 'Leave History',
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.noData.value) {
            return const BuildNullIconText(
              icon: Icons.airplanemode_off_outlined,
              text: 'Leave history not found',
            );
          } else {
            final leaves = controller.filteredLeaveHistory.isEmpty
                ? controller.leaveHistory
                : controller.filteredLeaveHistory;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 120, top: 20),
              itemCount: leaves.length,
              itemBuilder: (context, index) {
                final leave = leaves[index];
                return BuildCardInfo(
                  title: '${leave.firstName} ${leave.lastName}',
                  subtitle: '${leave.leaveCategory}',
                  appStatus: '${leave.status}',
                  startDate: '${leave.startDate}',
                  endDate: '${leave.endDate}',
                  icon: Icon(
                    Icons.date_range,
                    size: 16,
                    color: AppColor.textBody,
                  ),
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.leaveDetail,
                      arguments: {'leave': leave},
                    )?.then((result) {
                      if (result != null && result is int) {
                        controller.filterByNip(result);
                      }
                    });
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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Filter Leave History',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                if (!controller.isOnUserPage)
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Employee',
                      border: OutlineInputBorder(),
                    ),
                    items: ['All', ...controller.userItems].map((String user) {
                      return DropdownMenuItem<String>(
                        value: user,
                        child: Text(user),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedUser.value = value!;
                    },
                  ),
                if (!controller.isOnUserPage) const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Pending', 'Approved', 'Declined', 'Canceled', 'All']
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
                            controller.startDateController.value.text =
                                pickedDate.toIso8601String().substring(0, 10);
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
                            controller.endDateController.value.text =
                                pickedDate.toIso8601String().substring(0, 10);
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
                    if ((startDate != null && endDate == null) ||
                        (startDate == null && endDate != null)) {
                      Get.snackbar('Error', 'Data tanggal harus diisi semua');
                      return;
                    }
                    controller.startDateController.value.clear();
                    controller.endDateController.value.clear();
                    controller.filterLeaves();
                    Get.back();
                  },
                  title: 'Apply Filter',
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
