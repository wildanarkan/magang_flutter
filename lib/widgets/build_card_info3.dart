import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_status.dart';

class BuildCardInfo3 extends StatelessWidget {
  const BuildCardInfo3({
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
                  city,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColor.textBody,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  company,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColor.textTitle,
                  ),
                ),
              ],
            ),
            _getAppStatusWidget(appStatus),
          ],
        ),
      ],
    );

    if (useContainer) {
      content = Container(
        decoration: BoxDecoration(
          color: AppColor.backgroundOnProgress,
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
      case 'pending':
        return _pendingStatusWidget();
      case 'approved':
        return AppStatus.complete();
      case 'decline':
        return AppStatus.decline();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _pendingStatusWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColor.backgroundContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Pending',
        style: TextStyle(
          color: AppColor.textContainer,
        ),
      ),
    );
  }
}
