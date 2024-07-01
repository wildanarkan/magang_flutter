import 'package:flutter/material.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class LeaveHistoryPage extends StatelessWidget {
  const LeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BuildTestAppbar(
        title: 'Leave'),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30 ,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.task,
                      size: 24,),
                      SizedBox(width: 20,),
                      Text(
                        'Approval',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,
                  size: 20,)
                ],
              ),
            )
          ],
        ),
    );
  }
}