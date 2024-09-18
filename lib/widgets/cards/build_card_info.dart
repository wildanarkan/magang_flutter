import 'package:flutter/material.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_status.dart';

class BuildCardInfo extends StatelessWidget {
  const BuildCardInfo({
    super.key,
    this.subtitle,
    required this.title,
    required this.appStatus,
    this.padding = const EdgeInsets.only(bottom: 20),
    this.useContainer = true,
    this.icon,
    this.onTap,
    this.startDate,
    this.endDate,
  });

  final String? subtitle;
  final String title;
  final String? startDate;
  final String? endDate;
  final String appStatus;
  final EdgeInsetsGeometry padding;
  final bool useContainer;
  final Widget? icon;
  final VoidCallback? onTap;

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
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColor.textTitle,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (subtitle != null)
                  Text(
                    subtitle ?? '',
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
            icon ??
                Icon(
                  Icons.access_time_filled,
                  color: AppColor.iconBrown,
                  size: 16,
                ),
            const SizedBox(
              width: 5,
            ),
            Text(
              startDate ?? 'kosong',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColor.textBody,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '-',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColor.textBody,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              endDate ?? 'kosong',
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
      content = GestureDetector(
        onTap: onTap,
        child: Container(
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
        ),
      );
    } else {
      content = GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,      
          ),
          child: content,
        ),
      );
    }

    return Padding(
      padding: padding,
      child: content,
    );
  }

  Widget _getAppStatusWidget(String status) {
    switch (status) {
      case 'On Progress':
        return AppStatus.onProgress();
      case 'Completed':
        return AppStatus.complete(null);
      case 'Declined':
        return AppStatus.decline(null);
      case 'Pending':
        return AppStatus.pending();
      case 'Approved':
        return AppStatus.complete('Approved');
      case 'Canceled':
        return AppStatus.canceled('Canceled');
      case 'Draft':
        return AppStatus.draft();
      default:
        return const SizedBox.shrink();
    }
  }
}
