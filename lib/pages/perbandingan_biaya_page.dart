import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_biaya_card.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_widget_between.dart';

class PerbandinganBiayaPage extends StatelessWidget {
  const PerbandinganBiayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Perbandingan Biaya',
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: ListView(
              children: const [
                BuildBiayaCard(
                  title: 'Hotel',
                  persentase: '0',
                  estimasi: 'Rp 1.000.000,00',
                  realisasi: 'Rp 1.000.000,00',
                ),
                BuildBiayaCard(
                  title: 'Konsumsi',
                  persentase: '5',
                  estimasi: 'Rp 200.000,00',
                  realisasi: 'Rp 190.000,00',
                ),
                BuildBiayaCard(
                  title: 'Transportasi',
                  persentase: '5',
                  estimasi: 'Rp 400.000,00',
                  realisasi: 'Rp 470.000,00',
                  minusPersentase: true,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BuildWidgetBetween(
                    leftWidget: Text(
                      'Total Estimasi',
                      style: TextStyle(
                        color: AppColor.textBody,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    rightWidget: Text(
                      'Rp 1.600.000,00',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  BuildWidgetBetween(
                    leftWidget: Text(
                      'Total Realisasi',
                      style: TextStyle(
                        color: AppColor.textBody,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    rightWidget: Text(
                      'Rp 1.660.000,00',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  BuildWidgetBetween(
                    leftWidget: Text(
                      'Perbedaan Biaya',
                      style: TextStyle(
                        color: AppColor.textBody,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    rightWidget: Text(
                      'Rp 60.000,00',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
