import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/leave_request_detail_page.dart';
import 'package:magang_flutter/widgets/build_card_info.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class EmployeeLeaveHistoryPage extends StatelessWidget {
  const EmployeeLeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  BuildTestAppbar(
        title: 'Leave History',
        actions: [
          IconButton(
            onPressed: (){}, icon: const Icon(
              Icons.filter_alt_rounded
            ),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          padding: const EdgeInsets.only(bottom: 120, top: 20),
          children: [
            BuildCardInfo(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'pending',
               icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
            BuildCardInfo(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
               icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
            BuildCardInfo(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
               icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
             BuildCardInfo(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'decline',
               icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ), BuildCardInfo(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
               icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ), BuildCardInfo(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
               icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ), BuildCardInfo(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
               icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
