import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildItemContract extends StatelessWidget {
  const BuildItemContract({
    super.key,
    this.text,
    this.start_date,
    this.end_date,
  });

  final String? text;
  final String? start_date;
  final String? end_date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text ?? 'Monthly Payroll',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    start_date ?? '0000-00-00',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColor.textBody,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '-',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColor.textBody,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    end_date ?? '0000-00-00',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColor.textBody,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
