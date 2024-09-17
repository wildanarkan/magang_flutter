import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_routes.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/buttons/build_button_icon.dart';

class LeaveHistoryPage extends GetView<NavigatorPageControllers> {
  const LeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    log('priorityku :${controller.rolePriority.value}');

    return Scaffold(
      appBar: const BuildAppbar(
        title: 'Leave',
        paddingTitle: EdgeInsets.only(left: 20),
      ),
      body: Obx(() {
        if (controller.rolePriority.value == 0) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            if (controller.rolePriority.value <= 2)
              BuildButtonIcon(
                icon: Icons.task,
                title: 'Approval',
                iconColor: AppColor.primary,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.leaveList,
                    arguments: {
                      'pendingPage': true,
                    },
                  );
                },
              ),
            BuildButtonIcon(
              icon: Icons.task_alt,
              iconColor: AppColor.primary,
              title: 'Make Leave Application',
              onTap: () {
                Get.toNamed(AppRoutes.leaveAdd);
              },
            ),
            if (controller.rolePriority.value <= 2)
              BuildButtonIcon(
                icon: Icons.people_alt,
                iconColor: AppColor.primary,
                title: 'Employee Leave History',
                onTap: () {
                  Get.toNamed(
                    AppRoutes.leaveList,
                    arguments: {
                      'pendingPage': false,
                    },
                  );
                },
              ),
            BuildButtonIcon(
              icon: Icons.person,
              iconColor: AppColor.primary,
              title: 'Personal Leave History',
              onTap: () {
                Get.toNamed(AppRoutes.leavePersonal);
              },
            ),
          ],
        );
      }),
    );
  }
}
