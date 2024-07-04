import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildIconRoundedAdd extends StatelessWidget {
  const BuildIconRoundedAdd({
    super.key,
    this.size,
    this.rounded,
    required this.onPressed, this.padding,
  });

  final double? size;
  final double? rounded;
  final double? padding;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded ?? 20.0),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(AppColor.primary),
      ),
      icon: const Icon(
        Icons.add_rounded,
        // size: size ?? 20,
      ),
      iconSize: 20,
      padding: EdgeInsets.all(padding ?? 10),
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      color: Colors.white,
    );
  }
}
