import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_status.dart';
import 'package:magang_flutter/controllers/leave_request_detail_controller_page.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/data/models/leave_model.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/buttons/build_button.dart';
import 'package:magang_flutter/widgets/texts/build_text_column.dart';
import 'package:magang_flutter/widgets/texts/build_text_link.dart';

class LeaveRequestDetailPage extends StatelessWidget {
  final Leaves leave;

  const LeaveRequestDetailPage({super.key, required this.leave});

  @override
  Widget build(BuildContext context) {
    final NavigatorPageControllers navigatorPageControllers =
        Get.find<NavigatorPageControllers>();
    final controller = Get.put(LeaveRequestDetailController()); // Tambahkan ini

    return Scaffold(
      appBar: const BuildAppbar(
        title: 'Leave Request',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${leave.firstName} ${leave.lastName}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            leave.nip.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          BuildTextLink(
                            title: 'Look Employee History',
                            context: context,
                            onTap: () {
                              Get.back(
                                  result: leave
                                      .nip); // Kirim nip ke halaman sebelumnya
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Leave Category',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.textBody),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                leave.leaveCategory ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          _getAppStatusWidget(leave.status.toString()),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: BuildTextColumn(
                              title: 'Start Date',
                              date: leave.startDate,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: BuildTextColumn(
                              title: 'End Date',
                              date: leave.endDate,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              if (navigatorPageControllers.rolePriority.value <= 2 &&
                  navigatorPageControllers.nip != leave.nip &&
                  leave.status != 'Approved')
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: BuildButton(
                    context: context,
                    title: 'Accept',
                    width: 320,
                    onPressed: () async {
                      await controller.updateLeaveStatus(leave.id!, 'Approved');
                      log(leave.id.toString());
                      log('Approved');
                    },
                  ),
                ),
              if (navigatorPageControllers.rolePriority.value <= 2 &&
                  navigatorPageControllers.nip != leave.nip &&
                  leave.status != 'Declined')
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 20),
                  child: BuildButton(
                    context: context,
                    title: 'Reject',
                    backgroundColor: Colors.white,
                    foregroundColor: AppColor.decline,
                    borderColor: AppColor.decline,
                    width: 320,
                    onPressed: () async {
                      await controller.updateLeaveStatus(leave.id!, 'Declined');
                      log(leave.id.toString());
                      log('Declined');
                    },
                  ),
                ),
              if (leave.nip == navigatorPageControllers.nip.value &&
                  leave.status != 'Canceled')
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 40),
                  child: BuildButton(
                    context: context,
                    title: 'Cancel',
                    backgroundColor: AppColor.decline,
                    foregroundColor: Colors.white,
                    borderColor: AppColor.decline,
                    width: 320,
                    onPressed: () async {
                      await controller.updateLeaveStatus(leave.id!, 'Canceled');
                      log(leave.id.toString());
                      log('canceled');
                    },
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

Widget _getAppStatusWidget(String status) {
  switch (status) {
    case 'onProgress':
      return AppStatus.onProgress();
    case 'Complete':
      return AppStatus.complete(null);
    case 'Declined':
      return AppStatus.decline(null);
    case 'Pending':
      return AppStatus.pending();
    case 'Approved':
      return AppStatus.complete('Approved');
    case 'Canceled':
      return AppStatus.canceled('Canceled');
    default:
      return const SizedBox.shrink();
  }
}
