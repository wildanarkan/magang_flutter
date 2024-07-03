import 'package:flutter/material.dart';
import 'package:magang_flutter/pages/leave_request_detail_page.dart';
import 'package:magang_flutter/widgets/build_card_info4.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class PersonalLeaveHistoryPage extends StatelessWidget {
  const PersonalLeaveHistoryPage({super.key});

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
            BuildCardInfo4(
              company: "Cuti Tahunan",
              appStatus: 'pending',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
            BuildCardInfo4(
              company: "Cuti Tahunan",
              appStatus: 'approved',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
            BuildCardInfo4(
              company: "Cuti Hamil",
              appStatus: 'approved',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestDetailPage(),
                  ),
                );
              },
            ),
             BuildCardInfo4(
              company: "Cuti Tahunan",
              appStatus: 'decline',
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
