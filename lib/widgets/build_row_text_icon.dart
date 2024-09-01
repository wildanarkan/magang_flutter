import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildRowTextIcon extends StatelessWidget {
  const BuildRowTextIcon({
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