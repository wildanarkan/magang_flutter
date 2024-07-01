import 'package:flutter/material.dart';
import 'package:magang_flutter/pages/business_trip_detail_page.dart';
import 'package:magang_flutter/pages/business_trip_page.dart';
import 'package:magang_flutter/pages/home_page.dart';
import 'package:magang_flutter/pages/wallet_page.dart';
import 'package:magang_flutter/widgets/build_button.dart';

class WidgetPage extends StatelessWidget {
  const WidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Widget'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          BuildButton(
            context: context,
            title: 'Businness Trip Page',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BusinessTripPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 15,),
          BuildButton(
            context: context,
            title: 'Home Page',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          const SizedBox(height: 15,),
          BuildButton(
            context: context,
            title: 'Business Trip Detail Page',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BusinessTripDetailPage(),
                ),
              );
            },
          ),
          BuildButton(
            context: context,
            title: 'wallet page',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WalletPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
