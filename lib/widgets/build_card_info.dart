import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_status.dart';

class BuildCardInfo extends StatelessWidget {
  const BuildCardInfo({
    super.key,
    required this.city,
    required this.company,
    required this.appStatus,
    this.padding = const EdgeInsets.only(bottom: 20),
    this.useContainer = true,
  });

  final String city;
  final String company;
  final String appStatus;
  final EdgeInsetsGeometry padding;
  final bool useContainer;

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColor.textTitle,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  city,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColor.textBody,
                  ),
                ),
              ],
            ),
            _getAppStatusWidget(appStatus),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Icon(
              Icons.access_time_filled,
              color: AppColor.iconBrown,
              size: 24,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColor.textBody,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text('-'),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColor.textBody,
              ),
            ),
          ],
        ),
      ],
    );

    if (useContainer) {
      content = Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            width: 1,
            color: AppColor.line,
          ),
        ),
        child: content,
      );
    }

    return Padding(
      padding: padding,
      child: content,
    );
  }

  Widget _getAppStatusWidget(String status) {
    switch (status) {
      case 'onProgress':
        return AppStatus.onProgress();
      case 'complete':
        return AppStatus.complete();
      case 'decline':
        return AppStatus.decline();
      default:
        return const SizedBox.shrink();
    }
  }
}
