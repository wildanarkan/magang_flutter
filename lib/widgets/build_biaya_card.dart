import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_status.dart';
import 'package:magang_flutter/widgets/build_widget_between.dart';

class BuildBiayaCard extends StatelessWidget {
  const BuildBiayaCard({
    super.key,
    required this.title,
    required this.persentase,
    required this.estimasi,
    required this.realisasi,
    this.minusPersentase = false,
  });

  final String title;
  final String persentase;
  final String estimasi;
  final String realisasi;
  final bool? minusPersentase;

  // In BuildBiayaCard
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BuildWidgetBetween(
              leftWidget: Text(
                title,
                style: TextStyle(
                  color: AppColor.textTitle,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              rightWidget: minusPersentase == false
                  ? AppStatus.complete('$persentase%')
                  : AppStatus.decline('$persentase%'),
              padding: const EdgeInsets.all(0),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(),
            ),
            BuildWidgetBetween(
              leftWidget: Text(
                estimasi,
                style: TextStyle(
                  color: AppColor.textBody,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              rightWidget: Text(
                realisasi,
                style: TextStyle(
                  color: AppColor.textTitle,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              padding: const EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }
}
