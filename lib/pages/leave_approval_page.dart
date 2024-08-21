import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_card_info.dart';
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
            BuildCardInfo(
              title: "Agung Supratman",
              subtitle: 'Cuti Tahunan',
              appStatus: 'pending',
              icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
            ),
            BuildCardInfo(
              title: "Maman Sudrajat",
              subtitle: 'Cuti Tahunan',
              appStatus: 'approved',
               icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
            ),
            BuildCardInfo(
              title: "Joko Sasongko",
              subtitle: 'Cuti Tahunan',
              appStatus: 'approved',
               icon: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColor.textBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
