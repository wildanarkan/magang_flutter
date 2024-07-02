import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_expansion_biaya.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_between.dart';
import 'package:magang_flutter/widgets/build_total.dart';

class EstimasiBiayaPage extends StatelessWidget {
  const EstimasiBiayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildTestAppbar(
        title: 'Estimasi Biaya',
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
                  'Rp 1.150.000,00',
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
                  BuildTextBetween(
                    leftText: Text(
                      'Cempaka',
                      style: TextStyle(
                        color: AppColor.textBody,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    rightText: Text(
                      'Rp 1.000.000,00',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  BuildTextBetween(
                    leftText: Text(
                      'Kereta',
                      style: TextStyle(
                        color: AppColor.textBody,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    rightText: Text(
                      'Rp 150.000,00',
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
                  'Rp 200.000,00',
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
                  'Rp 350.000,00',
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
