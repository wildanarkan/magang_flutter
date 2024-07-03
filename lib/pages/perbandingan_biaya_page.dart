import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_status.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_between.dart';

class PerbandinganBiayaPage extends StatelessWidget {
  const PerbandinganBiayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Perbandingan Biaya',
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  BuildTextBetween(
                    leftText: Text(
                      'Hotel',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    rightText: AppStatus.complete('0%'),
                  ),
                  const Divider(),
                  BuildTextBetween(
                    leftText:  Text(
                      'Rp 1.000.000,00',
                      style: TextStyle(
                        color: AppColor.textBody,
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                      ),
                    ),
                    rightText: Text(
                      'Rp 1.000.000,00',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
