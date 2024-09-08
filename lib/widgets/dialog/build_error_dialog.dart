import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_button.dart';

class BuildErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;

  const BuildErrorDialog({
    super.key,
    this.title = "Error",
    this.message = "Something went wrong!",
    this.buttonText = "Oke",
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
            Icon(
              Icons.warning_amber_rounded,
              size: 100,
              color: AppColor.primary,
            ),
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
                    title: buttonText,
                    width: 88,
                    height: 40,
                    onPressed: () {
                      Get.back();
                    },
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
