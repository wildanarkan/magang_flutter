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
  RxString firstName = 'Null'.obs;
  RxString lastName = 'Null'.obs;
  RxString profilePhotoUrl = ''.obs;
  String? accessToken; // Tambahkan ini untuk menyimpan token
  int? userId; // Tambahkan ini untuk menyimpan ID pengguna

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
        userId = data['result']['id']; // Ambil ID pengguna
        profilePhotoUrl.value = data['result']['profile_photo'] ?? '';

        // Panggil fetchProfileData dengan ID
        if (userId != null) {
          fetchProfileData(userId!);
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchProfileData(int id) async {
    final String url = '${URLs.profile}$id'; // Pastikan URL benar

    try {
      // final response = await http.get(Uri.parse(url));
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Berhasil mendapatkan data
        final data = json.decode(response.body);
        final role = data['role'];
        firstName.value = data['first_name'] ?? 'No Data';
        lastName.value = data['last_name'] ?? 'No Data';
        print('Role: $role');
      } else {
        // Error handling
        print('Failed to load profile data: ${response.statusCode}');
      }
    } catch (e) {
      // Error handling untuk koneksi atau lainnya
      print('Error occurred: $e');
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
