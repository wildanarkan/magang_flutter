import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/ask_leave_page.dart';
import 'package:magang_flutter/pages/employee_leave_history_page.dart';
import 'package:magang_flutter/pages/leave_approval_page.dart';
import 'package:magang_flutter/pages/personal_leave_history_page.dart';
import 'package:magang_flutter/widgets/build_rowicon.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class LeaveHistoryPage extends StatelessWidget {
  const LeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Leave'),
        body: Column(
          children: [
            BuildRowicon(
              icon: Icons.task,
              title: 'Approval',
              iconColor: AppColor.primary,
              onTap: (){
               Get.to(() => const LeaveRequestPage());
              },
               ),
               BuildRowicon(
              icon: Icons.task_alt,
              iconColor: AppColor.primary,
              title: 'Make Leave Application',
              onTap: (){
              Get.to(() => const AskLeavePage());
              }, ),
               BuildRowicon(
              icon: Icons.people_alt,
              iconColor: AppColor.primary,
              title: 'Employee Leave History',
              onTap: (){
               Get.to(() => const EmployeeLeaveHistoryPage());
              }, ),
               BuildRowicon(
              icon: Icons.person,
              iconColor: AppColor.primary,
              title: 'Personal Leave History',
              onTap: (){
              Get.to(() => const PersonalLeaveHistoryPage());
              }, ),
          ],
        ),
    );
  }
}
