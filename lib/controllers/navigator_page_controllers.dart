import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/pages/business_trip_page.dart';
import 'package:magang_flutter/pages/home_page.dart';
import 'package:magang_flutter/pages/profile_page.dart';
import 'package:magang_flutter/pages/widget_page.dart';

class NavigatorPageControllers extends GetxController {
  RxInt selectedPage = 0.obs;

  List<Widget> page = [
    const HomePage(),
    const BusinessTripPage(),
    const WidgetPage(),
    const ProfilePage(),
  ].obs;

    void changePage(int index) {
    selectedPage.value = index;
  }
}
