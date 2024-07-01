import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/payroll_history_page.dart';
import 'package:magang_flutter/widgets/build_rowicon.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class LeaveHistoryPage extends StatelessWidget {
  const LeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Leave'),
        body: Column(
          children: [
            BuildRowicon(
              icon: Icons.task,
              title: 'Approval',
              iconColor: AppColor.primary,
              onTap: (){
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PayrollHistoryPage(),
                ),
              );
              },
               ),
               BuildRowicon(
              icon: Icons.task_alt,
              iconColor: AppColor.primary,
              title: 'Make Leave Application',
              onTap: (){
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PayrollHistoryPage(),
                ),
              );
              }, ),
               BuildRowicon(
              icon: Icons.people_alt,
              iconColor: AppColor.primary,
              title: 'Employee Leave History',
              onTap: (){
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PayrollHistoryPage(),
                ),
              );
              }, ),
               BuildRowicon(
              icon: Icons.person,
              iconColor: AppColor.primary,
              title: 'Personal Leave History',
              onTap: (){
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PayrollHistoryPage(),
                ),
              );
              }, ),
          ],
        ),
    );
  }
}


