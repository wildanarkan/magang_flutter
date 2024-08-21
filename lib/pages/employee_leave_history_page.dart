import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/leave_page_controller.dart';
import 'package:magang_flutter/data/models/leave_model.dart';
import 'package:magang_flutter/pages/leave_request_detail_page.dart';
import 'package:magang_flutter/widgets/build_card_info.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class EmployeeLeaveHistoryPage extends StatefulWidget {
  final String? statusFilter;
  const EmployeeLeaveHistoryPage({super.key, this.statusFilter});

  @override
  _EmployeeLeaveHistoryPageState createState() =>
      _EmployeeLeaveHistoryPageState();
}

class _EmployeeLeaveHistoryPageState extends State<EmployeeLeaveHistoryPage> {
  int? nip;

  @override
  void initState() {
    super.initState();
    // Ambil nip dari arguments jika tersedia
    nip = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    final LeavePageController controller = Get.put(LeavePageController());

    return Scaffold(
      appBar: BuildTestAppbar(
        title: 'Employee Leave History',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_rounded),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Obx(() {
          // Filter leaves berdasarkan nip
          List<Leaves> filteredLeaves = controller.leaves;

          if (widget.statusFilter != null) {
            filteredLeaves = controller.leaves.where((leave) =>
              leave.status == 'Pending').toList();
              log(widget.statusFilter.toString());
          }

          if(nip != null){
            filteredLeaves = controller.leaves.where((leave) => leave.nip == nip).toList();
            log(nip.toString());
          }

          if (filteredLeaves.isEmpty) {
            return const Center(child: CircularProgressIndicator());
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
}
