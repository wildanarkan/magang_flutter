import 'package:flutter/material.dart';
import 'package:magang_flutter/pages/leave_request_detail_page.dart';
import 'package:magang_flutter/widgets/build_card_info2.dart';
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
            BuildCardInfo2(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'pending',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
            BuildCardInfo2(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
            BuildCardInfo2(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
             BuildCardInfo2(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'decline',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ), BuildCardInfo2(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ), BuildCardInfo2(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ), BuildCardInfo2(
              city: 'Cuti Tahunan',
              company: "Agung Supratman",
              appStatus: 'approved',
              onPressed: () {
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
