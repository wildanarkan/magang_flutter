import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildListEmployee extends StatelessWidget {
  const BuildListEmployee({super.key, required this.nameEmployee});
  final String nameEmployee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: AppColor.iconBrown,
            size: 24,
          ),
          const SizedBox(width: 20,),
          Text(
            nameEmployee,
            style: TextStyle(
              color: AppColor.textTitle,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}