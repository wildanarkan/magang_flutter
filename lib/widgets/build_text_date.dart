import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildTextDate extends StatelessWidget {
  final String title;
  final String? date;

  const BuildTextDate({
    super.key,
    required this.title, this.date,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColor.textBody,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          date ?? 'kosong',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
