import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';
import 'package:magang_flutter/data/repo/business_trip_repository.dart';
import 'package:magang_flutter/data/repo/company_repository.dart';

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
  // Repository
  final CompanyRepository companyRepository = Get.find<CompanyRepository>();
  final BusinessTripRepository _businessTripRepository =
      Get.find<BusinessTripRepository>();

  // Model
  var businessTrips = <BusinessTripModel>[].obs;
  var filteredBusinessTrips = <BusinessTripModel>[].obs;
  var companyItem = <String>[].obs;

  // Bool
  var isLoading = true.obs;
  var noData = false.obs;

  // Variable
  var selectedStatus = Rxn<String>();
  var selectedCompany = Rxn<String>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedStartDate = Rxn<DateTime>();

  // Text Editing Controller
  var endDateController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanyItems();
    fetchBusinessTrips();
    resetFilter();
  }

  Future<void> fetchBusinessTrips() async {
    try {
      isLoading(true);
      final trips = await _businessTripRepository.fetchAll();
      businessTrips.value = trips;
      filterBusinessTrips();
    } catch (e) {
      print('Error fetching current business trips: $e');
    } finally {
      isLoading(false);
    }
  }

  void fetchCompanyItems() async {
    try {
      final data = await companyRepository.fetchCompany();
      companyItem.value =
          data.map<String>((item) => item['name'].toString()).toSet().toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load company items');
    }
  }

  BusinessTripModel? getTripById(int id) {
    return businessTrips.firstWhereOrNull((trip) => trip.idBusinessTrip == id);
  }

  void filterBusinessTrips() {
    final startDate = selectedStartDate.value;
    final endDate = selectedEndDate.value;

    if ((startDate != null && endDate == null) ||
        (startDate == null && endDate != null)) {
      Get.snackbar('Error', 'Data harus diisi semua');
      return;
    }

    filteredBusinessTrips.value = businessTrips.where((trip) {
      final matchesStatus = selectedStatus.value == null ||
          selectedStatus.value == 'All' ||
          trip.status == selectedStatus.value;

      final matchesCompany = selectedCompany.value == null ||
          selectedCompany.value == 'All' ||
          trip.companyName == selectedCompany.value;

      final tripStartDate = DateTime.parse(trip.startDate ?? '');

      final matchesDateRange = (startDate == null && endDate == null) ||
          (startDate != null &&
              endDate != null &&
              tripStartDate.isAtLeast(startDate) &&
              tripStartDate.isAtMost(endDate));

      return matchesStatus && matchesDateRange && matchesCompany;
    }).toList();

    noData.value = filteredBusinessTrips.isEmpty;
  }

  void resetFilter() {
    selectedStatus.value = 'All';
    selectedEndDate.value = null;
    selectedStartDate.value = null;
    selectedCompany.value = 'All';
    startDateController.value.clear();
    endDateController.value.clear();
  }
}
