import 'package:flutter/material.dart';
import 'package:nextbasis_hris/common/app_color.dart';

class BuildTextIcon extends StatelessWidget {
  const BuildTextIcon({
    super.key, required this.title, required this.subtitle, required this.icons,
  });

  final String title;
  final String subtitle;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icons,
          size: 18,
          color: AppColor.textTitle,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
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
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textTitle),
            ),
          ],
        )
      ],
    );
  }
}