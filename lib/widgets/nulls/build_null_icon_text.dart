import 'package:flutter/material.dart';
import 'package:nextbasis_hris/common/app_color.dart';

class BuildNullIconText extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final String? text;
  final double? textSize;
  final Color? textColor;
  final double? spacing;
  final EdgeInsetsGeometry? padding;

  const BuildNullIconText({
    super.key,
    required this.icon,
    this.text,
    this.iconSize,
    this.iconColor,
    this.textSize,
    this.textColor,
    this.spacing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize ?? 60,
              color: iconColor ?? AppColor.textBody,
            ),
            SizedBox(
              height: spacing ?? 0,
            ),
            Text(
              text ?? '',
              style: TextStyle(
                fontSize: textSize ?? 17,
                color: textColor ?? AppColor.textBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
