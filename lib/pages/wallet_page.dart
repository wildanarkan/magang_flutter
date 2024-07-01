import 'package:flutter/material.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BuildTestAppbar(title: 'Wallet'),
      
    );
  }
}