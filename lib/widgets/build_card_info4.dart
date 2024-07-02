import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_status.dart';

class BuildCardInfo4 extends StatelessWidget {
  const BuildCardInfo4({
    super.key,
    required this.company,
    required this.appStatus,
    required this.onPressed,
    this.padding = const EdgeInsets.only(bottom: 20),
    this.useContainer = true,
  });

  final String company;
  final String appStatus;
  final EdgeInsetsGeometry padding;
  final bool useContainer;
  final VoidCallback onPressed; 

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
                    fontSize: 14,
                    color: AppColor.textTitle,
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

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: content,
      ),
    );
  }

  Widget _getAppStatusWidget(String status) {
    switch (status) {
      case 'pending':
        return _pendingStatusWidget();
      case 'approved':
        return _completeStatusWidget();
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
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Pending',
        style: TextStyle(
          color: AppColor.textContainer, 
        ),
      ),
    );
  }

  Widget _completeStatusWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColor.backgroundComplete, 
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Text(
        'Approved',
        style: TextStyle(
          color: AppColor.complete,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
