import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildListEmployee extends StatelessWidget {
  const BuildListEmployee({
    super.key,
    required this.nameEmployee,
    required this.onDelete,
  });

  final String nameEmployee;
  final VoidCallback onDelete;

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
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              nameEmployee,
              style: TextStyle(
                color: AppColor.textTitle,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
