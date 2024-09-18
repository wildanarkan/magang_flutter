import 'package:flutter/material.dart';
import 'package:nextbasis_hris/common/app_color.dart';

class AppStatus {
  static Widget onProgress() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.backgroundOnProgress,
      ),
      child: Text(
        'On Progress',
        style: TextStyle(
          color: AppColor.onProgress,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static Widget complete(String? text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.backgroundComplete,
      ),
      child: Text(
        text ?? 'Complete',
        style: TextStyle(
          color: AppColor.complete,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static Widget decline(String? text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.backgroundDecline,
      ),
      child: Text(
        text ?? 'Declined',
        style: TextStyle(
          color: AppColor.decline,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static Widget pending() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.backgroundPending,
      ),
      child: Text(
        'Pending',
        style: TextStyle(
          color: AppColor.pending,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static Widget draft() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.backgroundDecline,
      ),
      child: Row(
        children: [
          Text(
            'Draft',
            style: TextStyle(
              color: AppColor.draft,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(
            Icons.edit,
            size: 10,
            color: AppColor.draft,
          ),
        ],
      ),
    );
  }

  static Widget canceled(String? text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.backgroundDecline,
      ),
      child: Text(
        text ?? 'Canceled',
        style: TextStyle(
          color: AppColor.decline,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
