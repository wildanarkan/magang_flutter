import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildTextLink extends StatelessWidget {
  const BuildTextLink({
    super.key,
    required BuildContext context,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: AppColor.primary,
              )
            ],
          ),
        ],
      ),
    );
  }
}
