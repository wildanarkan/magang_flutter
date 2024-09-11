import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/leave_page_controller.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/pages/leave/ask_leave_page.dart';
import 'package:magang_flutter/pages/leave/employee_leave_history_page.dart';
import 'package:magang_flutter/pages/leave/personal_leave_history_page.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/buttons/build_button_icon.dart';

class LeaveHistoryPage extends StatelessWidget {
  const LeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LeavePageController());

    final NavigatorPageControllers navigatorPageControllers =
        Get.find<NavigatorPageControllers>();
    log('priorityku :${navigatorPageControllers.rolePriority.value}');

    return Scaffold(
      appBar: const BuildAppbar(
        title: 'Leave',
        paddingTitle: EdgeInsets.only(left: 20),
      ),
      body: Obx(() {
        if (navigatorPageControllers.rolePriority.value == 0) {
          // Loading indicator until data is fetched
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            if (navigatorPageControllers.rolePriority.value <= 2)
              BuildButtonIcon(
                icon: Icons.task,
                title: 'Approval',
                iconColor: AppColor.primary,
                onTap: () {
                  Get.to(() => EmployeeLeaveHistoryPage(
                        statusFilter: 'Pending',
                      ));
                },
              ),
            BuildButtonIcon(
              icon: Icons.task_alt,
              iconColor: AppColor.primary,
              title: 'Make Leave Application',
              onTap: () {
                Get.to(() => const AskLeavePage());
              },
            ),
            if (navigatorPageControllers.rolePriority.value <= 2)
              BuildButtonIcon(
                icon: Icons.people_alt,
                iconColor: AppColor.primary,
                title: 'Employee Leave History',
                onTap: () {
                  Get.to(() => EmployeeLeaveHistoryPage());
                },
              ),
            BuildButtonIcon(
              icon: Icons.person,
              iconColor: AppColor.primary,
              title: 'Personal Leave History',
              onTap: () {
                Get.to(() => const PersonalLeaveHistoryPage());
              },
            ),
          ],
        );
      }),
    );
  }
}
