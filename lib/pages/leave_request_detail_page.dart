import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/employee_leave_history_page.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_link.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_date.dart';

class LeaveRequestDetailPage extends StatelessWidget {
  const LeaveRequestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildTestAppbar(title: 'Leave Request'),
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
                  padding:
                      const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Agung Supratman',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '21132132121',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          BuildLink(
                            title: 'Look Employee History',
                            context: context,
                            onTap: () {
                              Get.to(() => const EmployeeLeaveHistoryPage());
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
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Cuti Tahunan',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.backgroundPending,
                            ),
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                color: AppColor.pending,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: BuildTextDate(title: 'Start Date'),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: BuildTextDate(title: 'End Date'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: BuildButton(
              context: context,
              title: 'Accept',
              width: 320,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 0, 35, 40),
            child: BuildButton(
              context: context,
              title: 'Reject',
              backgroundColor: Colors.white,
              foregroundColor: AppColor.decline,
              borderColor: AppColor.decline,
              width: 320,
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
