import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({
    super.key,
    required BuildContext context,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor, this.height,
  });

  final String title;
  final double width;
  final double? height;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
              backgroundColor ?? AppColor.primary),
          foregroundColor:
              WidgetStateProperty.all<Color>(foregroundColor ?? Colors.white),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: borderColor ?? AppColor.primary)),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
