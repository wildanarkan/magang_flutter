import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildPayrollHistory extends StatelessWidget {
  const BuildPayrollHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: const EdgeInsets.fromLTRB(20,10,20,10),
          child: Container(
            decoration: BoxDecoration(
            color: Colors.white ,
              borderRadius: BorderRadius.circular(10)),
            width: double.infinity,
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30 ,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Monthly Payroll',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  Text(
                    DateFormat('dd-MM-yyyy')
                    .format(DateTime.now())
                    .toString(),
                    style:  TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColor.textBody
                    ),
                  )
                ],
              ),
            ),
          ),
        );
  }
}