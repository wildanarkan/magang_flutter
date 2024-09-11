import 'package:flutter/material.dart';

class BuildItemPayrollHistory extends StatelessWidget {
  const BuildItemPayrollHistory({
    super.key,
    required this.masterCategory,
    required this.payrollDate,
    required this.onTap,
    required this.payrollId,
  });

  final String masterCategory;
  final String payrollDate;
  final VoidCallback onTap;
  final String payrollId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  masterCategory,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  payrollDate,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
