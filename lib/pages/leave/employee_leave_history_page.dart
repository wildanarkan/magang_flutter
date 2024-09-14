import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/leave_page_controller.dart';
import 'package:magang_flutter/data/models/leave_model.dart';
import 'package:magang_flutter/pages/leave/leave_request_detail_page.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/cards/build_card_info.dart';

class EmployeeLeaveHistoryPage extends StatefulWidget {
  final LeavePageController controller = Get.find<LeavePageController>();

  String? statusFilter;

  EmployeeLeaveHistoryPage({super.key, this.statusFilter});

  @override
  _EmployeeLeaveHistoryPageState createState() =>
      _EmployeeLeaveHistoryPageState();
}

class _EmployeeLeaveHistoryPageState extends State<EmployeeLeaveHistoryPage> {
  int? nip;
  String? selectedStatusFilter;

  @override
  void initState() {
    super.initState();

    // Ambil controller dan fetch data leaves
    widget.controller.fetchLeaves();

    // Ambil nip dari arguments jika tersedia
    nip = Get.arguments;

    // Ambil statusFilter dari widget
    selectedStatusFilter = widget.statusFilter;
  }

  @override
  Widget build(BuildContext context) {
    final LeavePageController controller = Get.find<LeavePageController>();

    return Scaffold(
      appBar: BuildAppbar(
        title: 'Employee Leave History',
        actions: [
          if (widget.statusFilter != 'Pending')
            IconButton(
              onPressed: _showFilterBottomSheet,
              icon: const Icon(Icons.filter_alt_rounded),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Leaves> filteredLeaves = controller.leaves;

          // Jika NIP tersedia, filter data leave berdasarkan NIP terlebih dahulu
          if (nip != null) {
            filteredLeaves =
                filteredLeaves.where((leave) => leave.nip == nip).toList();
            log('Filtering by NIP: $nip');
          }

          // Jika statusFilter tersedia, filter lebih lanjut berdasarkan status
          if (selectedStatusFilter != null) {
            filteredLeaves = filteredLeaves
                .where((leave) => leave.status == selectedStatusFilter)
                .toList();
            log('Filtering by Status: $selectedStatusFilter');
            widget.statusFilter = null; // Reset status filter pada widget
          }

          if (filteredLeaves.isEmpty) {
            return Center(
                child: Text('No leave history ${selectedStatusFilter ?? ''}'));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 120, top: 20),
            itemCount: filteredLeaves.length,
            itemBuilder: (context, index) {
              final leave = filteredLeaves[index];
              return BuildCardInfo(
                title: "${leave.firstName} ${leave.lastName}",
                subtitle: leave.leaveCategory ?? '',
                appStatus: leave.status ?? 'pending',
                startDate: leave.startDate,
                endDate: leave.endDate,
                icon: Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: AppColor.textBody,
                ),
                onTap: () async {
                  final result =
                      await Get.to(() => LeaveRequestDetailPage(leave: leave));
                  if (result != null && result is int) {
                    setState(() {
                      nip = result;
                      selectedStatusFilter = widget
                          .statusFilter; // Reset status filter jika kembali
                    });
                  }
                },
              );
            },
          );
        }),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Pending'),
              onTap: () {
                setState(() {
                  selectedStatusFilter = 'Pending';
                });
                Get.back(closeOverlays: true);
              },
            ),
            ListTile(
              title: const Text('Approved'),
              onTap: () {
                setState(() {
                  selectedStatusFilter = 'Approved';
                });
                Get.back(closeOverlays: true);
              },
            ),
            ListTile(
              title: const Text('Declined'),
              onTap: () {
                setState(() {
                  selectedStatusFilter = 'Declined';
                });
                Get.back(closeOverlays: true);
              },
            ),
            ListTile(
              title: const Text('Canceled'),
              onTap: () {
                setState(() {
                  selectedStatusFilter = 'Canceled';
                });
                Get.back(closeOverlays: true);
              },
            ),
            ListTile(
              title: const Text('All'),
              onTap: () {
                setState(() {
                  selectedStatusFilter = null;
                });
                Get.back(closeOverlays: true);
              },
            ),
          ],
        );
      },
    );
  }
}
