import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';

class AddBusiniessTripPageController extends GetxController {
  var selectedCompany = ''.obs;
  var selectedCity = ''.obs;
  var selectedAllCity = ''.obs;
  var selectedAllUser = ''.obs;

  var companyItem = <String>[].obs;
  var cityItem = <String>[].obs;
  var allCityItem = <String>[].obs;
  var allUserItem = <String>[].obs;

  var isCityEnabled = false.obs;

  var startDateController = TextEditingController().obs;
  var endDateController = TextEditingController().obs;

  // Tambahkan variabel baru
  var address = ''.obs;
  var pic = ''.obs;
  var picRole = ''.obs;
  var picPhone = ''.obs;

  List<dynamic> _apiDataCompany = []; // Untuk menyimpan seluruh data dari API
  List<dynamic> _apiDataCity = []; // Untuk menyimpan seluruh data dari API
  List<dynamic> _apiDataAllCity = []; // Untuk menyimpan seluruh data dari API
  List<dynamic> _apiDataAllUser = []; // Untuk menyimpan seluruh data dari API

  void fetchCompanyItems() async {
    try {
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse(URLs.company), // Ganti dengan URL API Anda
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _apiDataCompany = json.decode(response.body);
        companyItem.value = _apiDataCompany
            .map((item) => item['name'].toString())
            .toSet()
            .toList();

        if (companyItem.isNotEmpty) {
          fetchCompanyCityItems();
          updateCityItems(selectedCompany.value);
        }
      } else {
        log(response.statusCode.toString());
        Get.snackbar('Error', 'Failed to load company items');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load company items');
    }
  }

  void fetchAllCityItems() async {
    try {
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse(URLs.city), // Ganti dengan URL API Anda
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _apiDataAllCity = json.decode(response.body);
        allCityItem.value = _apiDataAllCity
            .map((item) => item['name'].toString())
            .toSet()
            .toList();

      } else {
        log(response.statusCode.toString());
        Get.snackbar('Error', 'Failed to load all city items');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load all city items');
    }
  }

  void fetchAllUserItems() async {
    try {
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse(URLs.allUser), // Ganti dengan URL API Anda
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _apiDataAllUser = json.decode(response.body);
        allUserItem.value = _apiDataAllUser
            .map((item) => item['full_name'].toString())
            .toSet()
            .toList();

      } else {
        log(response.statusCode.toString());
        Get.snackbar('Error', 'Failed to load all user items');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load all user items');
    }
  }

  void fetchCompanyCityItems() async {
    try {
      final token = GetStorage().read('accessToken');

      final response = await http.get(
        Uri.parse(URLs.companyCity), // Ganti dengan URL API Anda
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _apiDataCity = json.decode(response.body);
        log(selectedCompany.value);
        log(selectedCity.value);
      } else {
        Get.snackbar('Error', 'Failed to load city items');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load city items');
    }
  }

  void updateCityItems(String company) {
    // Reset selectedCity and clear related fields
    selectedCity.value = '';
    clearCityRelatedData();

    // Filter data city berdasarkan company yang dipilih
    var filteredData =
        _apiDataCity.where((item) => item['company_name'] == company).toList();

    // Update city dropdown items
    cityItem.value =
        filteredData.map((item) => item['city_name'].toString()).toList();

    // Update isCityEnabled berdasarkan apakah ada city items yang tersedia
    isCityEnabled.value = cityItem.isNotEmpty;
    log('City Items: ${cityItem.value}');
    log('Selected City: ${selectedCity.value}');
  }

  void clearCityRelatedData() {
    address.value = '';
    pic.value = '';
    picRole.value = '';
    picPhone.value = '';
  }

  void updateCityRelatedData(String company, String city) {
    // Cari data yang sesuai dengan company dan city
    var data = _apiDataCity.firstWhere(
      (item) => item['company_name'] == company && item['city_name'] == city,
      orElse: () => null,
    );

    // Jika data ditemukan, perbarui field terkait
    if (data != null) {
      address.value = data['address'].toString();
      pic.value = data['pic'].toString();
      picRole.value = data['pic_role'].toString();
      picPhone.value = data['pic_phone'].toString();
    } else {
      clearCityRelatedData(); // Reset jika data tidak ditemukan
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCompanyItems();
    fetchAllCityItems();
    fetchAllUserItems();
  }
}
