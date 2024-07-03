import 'package:flutter/material.dart';

class BuildWidgetBetween extends StatelessWidget {
  const BuildWidgetBetween({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
    this.padding,
    this.onTap, 
  });

  final Widget leftWidget;
  final Widget rightWidget;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftWidget,
            rightWidget,
          ],
        ),
      ),
    );
  }
}
