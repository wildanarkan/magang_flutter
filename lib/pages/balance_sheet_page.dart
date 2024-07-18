import 'package:flutter/material.dart';
import 'package:magang_flutter/pages/balance_detail_page.dart';
import 'package:magang_flutter/widgets/build_icon_rounded_add.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_wallet_card.dart';

class BalanceSheetPage extends StatelessWidget {
  const BalanceSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildTestAppbar(
        paddingTitle: const EdgeInsets.only(left: 20),
        title: 'Balance Sheet',
        actions: [
          BuildIconRoundedAdd(
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
            BuildWalletCard(
              title: 'Uang Harian',
              content: 'Total: Rp.460.000,00',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BalanceDetailPage(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BuildWalletCard(
              title: 'Uang Transport',
              content: 'Total: Rp.460.000,00',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BalanceDetailPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
