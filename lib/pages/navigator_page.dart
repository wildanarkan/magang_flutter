import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/business_trip_page.dart';
import 'package:magang_flutter/pages/home_page.dart';
import 'package:magang_flutter/pages/profile_page.dart';
import 'package:magang_flutter/pages/widget_page.dart';
import 'package:magang_flutter/widgets/fab_bottom_app_bar.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int selectedPage = 0;

  List<Widget> page = [
    const HomePage(),
    const BusinessTripPage(),
    const WidgetPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [page[selectedPage], bottomNavigator()],
      ),
    );
  }

  Widget bottomNavigator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 81,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FABBottomAppBar(
              selectedColor: AppColor.textTitle,
              selectedIndex: selectedPage,
              onTabSelected: (index) {
                selectedPage = index;
                setState(() {});
              },
              items: [
                FABBottomAppBarItem(iconPage: Icons.home, title: 'Home'),
                FABBottomAppBarItem(iconPage: Icons.card_travel_rounded, title: 'Business Trip'),
                FABBottomAppBarItem(iconPage: Icons.account_balance_wallet_rounded, title: 'Wallet'),
                FABBottomAppBarItem(iconPage: Icons.person, title: 'Profile'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
