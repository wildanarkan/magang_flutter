import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/employee_leave_history_page.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_button_reject.dart';
import 'package:magang_flutter/widgets/build_card_info3.dart';
import 'package:magang_flutter/widgets/build_link.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_column.dart';
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
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.backgroundOnProgress,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EmployeeLeaveHistoryPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    const BuildCardInfo3(
                      city: 'Leave Category',
                      company: "Cuti Tahunan",
                      appStatus: 'pending',
                    ),
                    const SizedBox(height: 10),
                    const BuildTextColumn(title: 'duration', content: '3 Days'),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: BuildButton(
              context: context,
              title: 'Accept',
              width: 320,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 0, 35, 40),
            child: BuildButtonReject(
              context: context,
              title: 'Reject',
              width: 320,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
