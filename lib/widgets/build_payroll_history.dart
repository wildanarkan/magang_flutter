import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildPayrollHistory extends StatelessWidget {
  const BuildPayrollHistory({
    super.key,
    this.masterCategory, 
    this.payrollDate});

  final String? masterCategory;
  final String? payrollDate;

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
                masterCategory ?? 'Monthly Payroll',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Text(
                payrollDate ?? 'null' ,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.textBody),
              )
            ],
          ),
        ),
      ),
    );
  }
}
