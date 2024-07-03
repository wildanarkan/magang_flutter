import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildTextColumn extends StatelessWidget {
  final String title;
  final String content;

  const BuildTextColumn({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          content,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
