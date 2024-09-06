import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/pages/ask_leave_page.dart';
import 'package:magang_flutter/pages/employee_leave_history_page.dart';
import 'package:magang_flutter/pages/personal_leave_history_page.dart';
import 'package:magang_flutter/widgets/build_rowicon.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class LeaveHistoryPage extends StatelessWidget {
  const LeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorPageControllers navigatorPageControllers =
        Get.find<NavigatorPageControllers>();

    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Leave',
        paddingTitle: EdgeInsets.only(left: 20),
      ),
      body: Column(
        children: [
          if (navigatorPageControllers.role.value == 'Junior')
            BuildRowicon(
              icon: Icons.task,
              title: 'Approval',
              iconColor: AppColor.primary,
              onTap: () {
                Get.to(() => EmployeeLeaveHistoryPage(
                      statusFilter: 'Pending',
                    ));
              },
            ),
          BuildRowicon(
            icon: Icons.task_alt,
            iconColor: AppColor.primary,
            title: 'Make Leave Application',
            onTap: () {
              Get.to(() => const AskLeavePage());
            },
          ),
          if (navigatorPageControllers.role.value == 'Junior')
            BuildRowicon(
              icon: Icons.people_alt,
              iconColor: AppColor.primary,
              title: 'Employee Leave History',
              onTap: () {
                Get.to(() => EmployeeLeaveHistoryPage());
              },
            ),
          BuildRowicon(
            icon: Icons.person,
            iconColor: AppColor.primary,
            title: 'Personal Leave History',
            onTap: () {
              Get.to(() => const PersonalLeaveHistoryPage());
            },
          ),
        ],
      ),
    );
  }
}
