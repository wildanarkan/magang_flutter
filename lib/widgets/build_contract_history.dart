import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildContractHistory extends StatelessWidget {
  const BuildContractHistory({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                text ?? 'Monthly Payroll',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor.textBody),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('-',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColor.textBody)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor.textBody),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
