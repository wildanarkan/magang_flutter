import 'package:flutter/material.dart';
import 'package:magang_flutter/pages/leave_request_detail_page.dart';
import 'package:magang_flutter/widgets/build_card_info2.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class LeaveRequestPage extends StatelessWidget {
  const LeaveRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Leave Request',
        actions: [],
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
              company: "Maman Sudrajat",
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
              company: "Joko Sasongko",
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
