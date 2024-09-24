import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/common/app_status.dart';
import 'package:nextbasis_hris/controllers/leave_history_detail_controller.dart';
import 'package:nextbasis_hris/controllers/leave_personal_controller.dart';
import 'package:nextbasis_hris/controllers/navigator_controllers.dart';
import 'package:nextbasis_hris/data/models/leave_model.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';
import 'package:nextbasis_hris/widgets/texts/build_text_column.dart';
import 'package:nextbasis_hris/widgets/texts/build_text_link.dart';

class LeaveHistoryDetailPage extends GetView<LeaveHistoryDetailController> {
  final Leaves leave;

  const LeaveHistoryDetailPage({super.key, required this.leave});

  @override
  Widget build(BuildContext context) {
    final Leaves leave = Get.arguments['leave'];
    final NavigatorControllers navigatorPageControllers =
        Get.find<NavigatorControllers>();
    final LeavePersonalController leavePersonalPageController =
        Get.find<LeavePersonalController>();
    return Scaffold(
      appBar: const BuildAppbar(
        title: 'Leave Request',
      ),
      body: Padding(
        padding: EdgeInsets.all(AppComponent.marginPage),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                              leavePersonalPageController.resetFilter();
                              leavePersonalPageController.fetchLeaves();
                              Get.back(result: leave.nip);
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
                                  color: AppColor.textBody,
                                ),
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
            Column(
              children: [
                if (navigatorPageControllers.rolePriority.value <= 2 &&
                    navigatorPageControllers.nip.value != leave.nip &&
                    leave.status == 'Pending')
                  BuildButton(
                    context: context,
                    title: 'Accept',
                    width: double.infinity,
                    onPressed: () async {
                      await controller.updateLeaveStatus(leave.id!, 'Approved');
                      log(leave.id.toString());
                      log('Approved');
                    },
                  ),
                if (navigatorPageControllers.rolePriority.value <= 2 &&
                    navigatorPageControllers.nip.value != leave.nip &&
                    leave.status == 'Pending')
                  BuildButton(
                    context: context,
                    title: 'Reject',
                    backgroundColor: Colors.white,
                    foregroundColor: AppColor.decline,
                    borderColor: AppColor.decline,
                    width: double.infinity,
                    onPressed: () async {
                      await controller.updateLeaveStatus(leave.id!, 'Declined');
                      log(leave.id.toString());
                      log('Declined');
                    },
                  ),
                if (leave.nip == navigatorPageControllers.nip.value &&
                    leave.status == 'Pending')
                  BuildButton(
                    context: context,
                    title: 'Cancel',
                    backgroundColor: AppColor.decline,
                    foregroundColor: Colors.white,
                    borderColor: AppColor.decline,
                    width: double.infinity,
                    onPressed: () async {
                      await controller.updateLeaveStatus(leave.id!, 'Canceled');
                      log(leave.id.toString());
                      log('canceled');
                    },
                  ),
                const SizedBox.shrink()
              ]
                  .expand((widget) => [widget, const SizedBox(height: 16)])
                  .toList()
                ..removeLast(),
            ),
          ],
        ),
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
