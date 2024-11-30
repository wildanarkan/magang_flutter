import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nextbasis_hris/controllers/home_controller.dart';
import 'package:nextbasis_hris/controllers/trip_controller.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';
import 'package:nextbasis_hris/pages/business%20trip/trip_page.dart';
import 'package:nextbasis_hris/pages/home_page.dart';
import 'package:nextbasis_hris/pages/leave/leave_page.dart';
import 'package:nextbasis_hris/pages/profile/profile_page.dart';

class NavigatorControllers extends GetxController {
  RxInt selectedPage = 0.obs;
  RxString firstName = 'Null'.obs;
  RxString lastName = 'Null'.obs;
  RxString gender = 'Null'.obs;
  RxString religion = 'Null'.obs;
  RxString role = 'Null'.obs;
  RxInt rolePriority = 0.obs;
  RxInt employee_group = 0.obs;
  RxString position = 'Null'.obs;
  RxString phone_number = 'Null'.obs;
  RxString city = 'Null'.obs;
  RxString address = 'Null'.obs;
  RxString email = 'Null'.obs;
  RxInt nip = 0.obs;
  RxInt nik = 0.obs;
  RxString profilePhotoUrl = 'dudul1.jpeg'.obs;
  String? accessToken; // Tambahkan ini untuk menyimpan token
  int? userId; // Tambahkan ini untuk menyimpan ID pengguna
  final storage = GetStorage();

  final UserRepository _userRepository = Get.find<UserRepository>();

  @override
  void onInit() {
    // fetchUserData();
    super.onInit();
  }

  @override
  void onReady() {
    fetchUserData();
    super.onReady();
  }

  Future<void> fetchUserData() async {
    print('Fetching user data...');
    try {
      final data = await _userRepository.fetchUserData();
      userId = data['id']; // Ambil ID pengguna
      nik.value = data['nik'] ?? 'No Data';
      city.value = data['city'] ?? 'No Data';
      profilePhotoUrl.value = data['profile_photo'] ?? '';
      log('User Id :${userId.toString()}');

      if (userId != null) {
        print('Semua data di GetStorage:');
        storage.getKeys().forEach((key) {
          print('$key: ${storage.read(key)}');
        });

        final profileData = await _userRepository.fetchProfileData(userId!);
        firstName.value = profileData['first_name'] ?? 'No Data';
        lastName.value = profileData['last_name'] ?? 'No Data';
        gender.value = profileData['gender'] ?? 'No Data';
        religion.value = profileData['religion'] ?? 'No Data';
        role.value = profileData['role'] ?? 'No Data';
        rolePriority.value = profileData['priority'] ?? 'No Data';
        employee_group.value = profileData['employee_group'] ?? 'No Data';
        position.value = profileData['position'] ?? 'No Data';
        phone_number.value = profileData['phone_number'] ?? 'No Data';
        address.value = profileData['address'] ?? 'No Data';
        email.value = profileData['email'] ?? 'No Data';
        nip.value = profileData['nip'] ?? 'No Data';
        log('Role priority :${rolePriority.value}');
      }
    } catch (e) {
      print('Error fetching user or profile data: $e');
    }
  }

  List<Widget> page = [
    HomePage(),
    const TripPage(),
    const LeaveHistoryPage(),
    const ProfilePage(),
  ].obs;

  void changePage(int index) {
    if (selectedPage.value == 1) {
      log(selectedPage.toString());
      final tripController = Get.find<TripController>();
      tripController.fetchBusinessTrips();
      tripController.resetFilter();
    }
    if (selectedPage.value == 0) {
      log(selectedPage.toString());
      final homePageController = Get.find<HomePageController>();
      homePageController.fetchCheckinToday();
      homePageController.fetchCurrentBusinessTrips();
    }
    selectedPage.value = index;
  }
}
