import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/edit_biaya_page.dart';
import 'package:magang_flutter/widgets/build_expansion_biaya.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_total.dart';
import 'package:magang_flutter/widgets/build_widget_between.dart';

class RealisasiBiayaPage extends StatelessWidget {
  const RealisasiBiayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Realisasi Biaya',
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(25),
            children: [
              BuildExpansionBiaya(
                title: Text(
                  'Hotel',
                  style: TextStyle(
                    color: AppColor.textBody,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  'Rp 450.000,00',
                  style: TextStyle(
                    color: AppColor.textTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Divider(),
                  ),
                  BuildWidgetBetween(
                    leftWidget: Text(
                      'Cempaka',
                      style: TextStyle(
                        color: AppColor.textBody,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    rightWidget: Text(
                      'Rp 400.000,00',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  BuildWidgetBetween(
                    leftWidget: Text(
                      'Kereta',
                      style: TextStyle(
                        color: AppColor.textBody,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    rightWidget: Text(
                      'Rp 0,00',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  BuildWidgetBetween(
                    leftWidget: Text(
                      'Kena Cas',
                      style: TextStyle(
                        color: AppColor.textBody,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    rightWidget: Text(
                      'Rp 50.000,00',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              BuildExpansionBiaya(
                title: Text(
                  'Konsumsi',
                  style: TextStyle(
                    color: AppColor.textBody,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  'Rp 0,00',
                  style: TextStyle(
                    color: AppColor.textTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              BuildExpansionBiaya(
                title: Text(
                  'Transportasi',
                  style: TextStyle(
                    color: AppColor.textBody,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  'Rp 0,00',
                  style: TextStyle(
                    color: AppColor.textTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BuildTotal(
              total: 'IDR 1.600.000,00',
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditBiayaPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
