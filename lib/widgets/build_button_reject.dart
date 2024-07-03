import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildButtonReject extends StatelessWidget {
  const BuildButtonReject({
    super.key,
    required BuildContext context,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  final String title;
  final double width;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
              backgroundColor ?? Colors.white),
          foregroundColor:
              WidgetStateProperty.all<Color>(foregroundColor ?? AppColor.textBUtton),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: borderColor ?? AppColor.textBUtton)),
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
