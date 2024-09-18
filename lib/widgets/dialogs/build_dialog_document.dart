import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';

class BuildDialogDocument extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final Widget fileWidget;

  const BuildDialogDocument({
    super.key,
    required this.title,
    required this.message,
    this.confirmButtonText = 'Upload',
    this.cancelButtonText = 'Cancel',
    required this.onConfirm,
    required this.fileWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            fileWidget, // Menampilkan file yang dipilih
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.textBody,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.textBody,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: BuildButton(
                    title: cancelButtonText,
                    backgroundColor: Colors.white,
                    foregroundColor: AppColor.primary,
                    width: 88,
                    height: 40,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BuildButton(
                    title: confirmButtonText,
                    width: 88,
                    height: 40,
                    onPressed: onConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
