import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/pages/balance/balance_sheet_detail_page.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/buttons/build_button_rounded.dart';
import 'package:magang_flutter/widgets/cards/build_card_wallet.dart';

class BalanceSheetPage extends StatelessWidget {
  const BalanceSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar(
        paddingTitle: const EdgeInsets.only(left: 20),
        title: 'Balance Sheet',
        actions: [
          BuildButtonRounded(
            rounded: 9,
            size: 10,
            padding: 5,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            BuildCardWallet(
              title: 'Uang Harian',
              content: 'Total: Rp.460.000,00',
              onTap: () {
                Get.back();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BuildCardWallet(
              title: 'Uang Transport',
              content: 'Total: Rp.460.000,00',
              onTap: () {
                Get.to(() => const BalanceSheetDetailPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
