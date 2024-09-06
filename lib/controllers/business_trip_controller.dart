import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';

extension DateTimeComparison on DateTime {
  bool isAtLeast(DateTime date) {
    return isAfter(date.subtract(const Duration(seconds: 1))) ||
        isAtSameMomentAs(date);
  }

  bool isAtMost(DateTime date) {
    return isBefore(date.add(const Duration(days: 1))) ||
        isAtSameMomentAs(date);
  }
}

class BusinessTripController extends GetxController {
  var businessTrips = <BusinessTripModel>[].obs;
  var isLoading = true.obs;
  var selectedStatus = Rxn<String>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedStartDate = Rxn<DateTime>();
  var selectedCompany = Rxn<String>();
  var filteredBusinessTrips = <BusinessTripModel>[].obs;
  var noData = false.obs;

  var endDateController = TextEditingController().obs;
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

  BusinessTripModel? getTripById(int id) {
    return businessTrips.firstWhereOrNull((trip) => trip.idBusinessTrip == id);
  }

  void filterBusinessTrips() {
    // Validasi apakah kedua tanggal diisi
    if ((selectedStartDate.value != null && selectedEndDate.value == null) ||
        (selectedStartDate.value == null && selectedEndDate.value != null)) {
      Get.snackbar('Error', 'Data harus diisi semua');
      return; // Batalkan proses filter jika validasi gagal
    }

    // Lanjutkan dengan filter jika validasi berhasil
    filteredBusinessTrips.value = businessTrips.where((trip) {
      final matchesStatus = selectedStatus.value == null ||
          selectedStatus.value == 'All' ||
          trip.status == selectedStatus.value;

      final tripStartDate = DateTime.parse(trip.startDate ?? '');

      final startDate = selectedStartDate.value;
      final endDate = selectedEndDate.value;

      final matchesDateRange = (startDate == null && endDate == null) ||
          (startDate != null &&
              endDate == null &&
              tripStartDate.isAtLeast(startDate)) ||
          (startDate == null &&
              endDate != null &&
              tripStartDate.isAtMost(endDate)) ||
          (startDate != null &&
              endDate != null &&
              tripStartDate.isAtLeast(startDate) &&
              tripStartDate.isAtMost(endDate));

      final matchesCompany = selectedCompany.value == null ||
          selectedCompany.value == 'All' ||
          trip.companyName == selectedCompany.value;

      return matchesStatus && matchesDateRange && matchesCompany;
    }).toList();

    // Update nilai noData berdasarkan apakah ada data yang cocok
    noData.value = filteredBusinessTrips.isEmpty;
  }

  void resetFilter() {
    selectedStatus.value = 'All';
    selectedEndDate.value = null;
    selectedStartDate.value = null;
    selectedCompany.value = 'All';
    startDateController.value.clear();
    endDateController.value.clear();
    // filterBusinessTrips();
  }
}
