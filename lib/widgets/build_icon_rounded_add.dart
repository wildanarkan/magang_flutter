import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildIconRoundedAdd extends StatelessWidget {
  const BuildIconRoundedAdd({
    super.key,
    this.size,
    this.padding,
    required this.onPressed,
  });

  final double? size;
  final double? padding;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColor.primary)
      ),
      icon: Icon(
        Icons.add_rounded,
        size: size ?? 20,
      ),
      onPressed: onPressed,
      color: Colors.white,
    );
  }
}
