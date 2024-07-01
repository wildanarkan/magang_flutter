import 'package:flutter/material.dart';

class BuildStatus extends StatelessWidget {
  const BuildStatus({
    super.key, required this.title, required this.color, required this.backgroundColor,
  });

  final String title;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
          const Icon(Icons.app_blocking)
        ],
      ),
    );
  }
}
