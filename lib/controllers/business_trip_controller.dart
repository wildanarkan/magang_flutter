import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';

class BusinessTripController extends GetxController {
  var businessTrips = <BusinessTripModel>[].obs;
  var isLoading = true.obs;
  var selectedStatus = Rxn<String>();
  var selectedStartDate = Rxn<DateTime>();
  var selectedCompany = Rxn<String>();
  var filteredBusinessTrips = <BusinessTripModel>[].obs;
  var noData = false.obs;  // Menyimpan apakah ada data yang sesuai dengan filter atau tidak

  var startDateController = TextEditingController().obs;
  var companyItem = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanyItems();
    fetchBusinessTrips();
    resetFilter();

    // Langsung ke filter tanpa apply
    // selectedStatus.listen((_) => filterBusinessTrips());
    // selectedStartDate.listen((_) => filterBusinessTrips());
    // selectedCompany.listen((_) => filterBusinessTrips());
  }

  void fetchCompanyItems() async {
    try {
      final token = GetStorage().read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.company),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var apiDataCompany = json.decode(response.body);
        companyItem.value = apiDataCompany
            .map<String>((item) => item['name'].toString())
            .toSet()
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to load company items');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load company items');
    }
  }

  Future<void> fetchBusinessTrips() async {
    try {
      isLoading(true);
      final token = GetStorage().read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.business),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        log('Success fetch trip');
        List<dynamic> jsonData = json.decode(response.body);
        businessTrips.value =
            jsonData.map((json) => BusinessTripModel.fromJson(json)).toList();
        log(jsonData.toString());
        filterBusinessTrips(); // Apply filter after fetching data
      } else {
        // Handle error
        print(response.statusCode);
      }
    } catch (e) {
      // Handle exception
    } finally {
      isLoading(false);
    }
  }

  void filterBusinessTrips() {
    filteredBusinessTrips.value = businessTrips.where((trip) {
      final matchesStatus = selectedStatus.value == null ||
          selectedStatus.value == 'All' ||
          trip.status == selectedStatus.value;

      final matchesStartDate = selectedStartDate.value == null ||
          trip.startDate ==
              selectedStartDate.value?.toString().substring(0, 10);

      final matchesCompany = selectedCompany.value == null ||
          selectedCompany.value == 'All' ||
          trip.companyName == selectedCompany.value;

      return matchesStatus && matchesStartDate && matchesCompany;
    }).toList();

    // Update nilai noData berdasarkan apakah ada data yang cocok
    noData.value = filteredBusinessTrips.isEmpty;
  }

  void resetFilter() {
    selectedStatus.value = 'All';
    selectedStartDate.value = null;
    selectedCompany.value = 'All';
    startDateController.value.clear();
    // filterBusinessTrips();
  }
}
