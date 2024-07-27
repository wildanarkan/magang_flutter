import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/pages/balance_sheet_page.dart';
import 'package:magang_flutter/pages/business_trip_page.dart';
import 'package:magang_flutter/pages/home_page.dart';
import 'package:magang_flutter/pages/profile_page.dart';

class NavigatorPageControllers extends GetxController {
  RxInt selectedPage = 0.obs;
  RxString userName = 'No Data'.obs;
  String? accessToken; // Tambahkan ini untuk menyimpan token
  RxString profilePhotoUrl = ''.obs; // Menyimpan URL foto profil

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    print('Fetching user data...');
    try {
      final token = GetStorage().read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.user),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('User data: $data');
        userName.value = data['result']['name'] ?? 'No Name';
        profilePhotoUrl.value = data['result']['profile_photo'] ?? '';
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  List<Widget> page = [
    const HomePage(),
    const BusinessTripPage(),
    const BalanceSheetPage(),
    const ProfilePage(),
  ].obs;

  void changePage(int index) {
    selectedPage.value = index;
  }
}
