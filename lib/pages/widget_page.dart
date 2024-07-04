import 'package:flutter/material.dart';
import 'package:magang_flutter/pages/balance_sheet_detail_page.dart';
import 'package:magang_flutter/pages/balance_sheet_page.dart';
import 'package:magang_flutter/pages/business_trip_detail_page.dart';
import 'package:magang_flutter/pages/edit_biaya_page.dart';
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
          const SizedBox(height: 15,),
          BuildButton(
            context: context,
            title: 'Balance Sheet',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BalanceSheetPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 15,),
          BuildButton(
            context: context,
            title: 'Edit Biaya',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditBiayaPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 15,),
          BuildButton(
            context: context,
            title: 'Balance Sheet Detail',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BalanceSheetDetailPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
