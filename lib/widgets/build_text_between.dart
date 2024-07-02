import 'package:flutter/material.dart';

class BuildTextBetween extends StatelessWidget {
  const BuildTextBetween({
    super.key,
    required this.leftText,
    required this.rightText,
  });

  final Widget leftText;
  final Widget rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            leftText,
            rightText,
        ],
      ),
    );
  }
}