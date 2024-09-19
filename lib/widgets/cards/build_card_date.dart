import 'package:flutter/material.dart';
import 'package:nextbasis_hris/common/app_color.dart';

class BuildCardDate extends StatelessWidget {
  const BuildCardDate({
    super.key,
    required this.title,
    required this.startDate,
    this.onTap,
    this.endDate,
  });

  final String title;
  final String startDate;
  final String? endDate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(),
              ),
              Row(
                children: [
                  Text(
                    startDate,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColor.textBody,
                    ),
                  ),
                  if(endDate != null)
                  Text(
                    ' - ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColor.textBody,
                    ),
                  ),
                  Text(
                    endDate ?? '',
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
