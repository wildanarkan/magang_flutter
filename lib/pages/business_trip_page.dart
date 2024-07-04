import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/add_businiess_trip_page.dart';
import 'package:magang_flutter/widgets/build_card_info.dart';
import 'package:magang_flutter/widgets/build_icon_rounded_add.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class BusinessTripPage extends StatelessWidget {
  const BusinessTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildTestAppbar(
        paddingTitle: const EdgeInsets.only(left: 20),
        title: 'Business Trip',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_alt_rounded,
              size: 24,
            ),
            color: AppColor.primary,
          ),
          BuildIconRoundedAdd(
            rounded: 9,
            size: 10,
            padding: 5,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddBusiniessTripPage(),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          padding: const EdgeInsets.only(bottom: 120, top: 20),
          children: const [
            BuildCardInfo(
                city: 'Surabaya',
                company: "PT TATA NIAGA",
                appStatus: 'complete'),
            BuildCardInfo(
              city: 'Bandung',
              company: "PT SINAR ABADI",
              appStatus: 'onProgress',
            ),
            BuildCardInfo(
              city: 'Jakarta',
              company: "PT SIDOMUNCUL",
              appStatus: 'decline',
            ),
            BuildCardInfo(
              city: 'Madura',
              company: "PT USAHA KREATIF",
              appStatus: 'complete',
            ),
            BuildCardInfo(
                city: 'Surabaya',
                company: "PT TATA NIAGA",
                appStatus: 'complete'),
            BuildCardInfo(
              city: 'Bandung',
              company: "PT SINAR ABADI",
              appStatus: 'onProgress',
            ),
            BuildCardInfo(
              city: 'Jakarta',
              company: "PT SIDOMUNCUL",
              appStatus: 'decline',
            ),
            BuildCardInfo(
              city: 'Madura',
              company: "PT USAHA KREATIF",
              appStatus: 'complete',
            )
          ],
        ),
      ),
    );
  }
}
