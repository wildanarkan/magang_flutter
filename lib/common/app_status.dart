import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

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

  static Widget complete() {
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
        'Complete',
        style: TextStyle(
          color: AppColor.complete,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static Widget decline() {
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
        'Declined',
        style: TextStyle(
          color: AppColor.decline,
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
          const SizedBox(width: 5,),
          Icon(
            Icons.edit,
            size: 10,
            color: AppColor.draft,
          ),
        ],
      ),
    );
  }
}
