import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/data/models/employee_name.dart';
import 'package:nextbasis_hris/data/repo/business_trip_repository.dart';
import 'package:nextbasis_hris/data/repo/city_repository.dart';
import 'package:nextbasis_hris/data/repo/company_repository.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

class TripAddController extends GetxController {
  // Repository
  final BusinessTripRepository _businessTripRepository =
      BusinessTripRepository();
  final UserRepository _userRepository = UserRepository();
  final CompanyRepository _companyRepository = CompanyRepository();
  final CityRepository _cityRepository = CityRepository();

  var selectedCompany = ''.obs;
  var selectedCity = ''.obs;
  var selectedAllCity = ''.obs;
  var selectedAllUser = ''.obs;

  var companyItem = <String>[].obs;
  var cityItem = <String>[].obs;
  var allCityItem = <String>[].obs;
  var allUserItem = <String>[].obs;

  RxList employeeList = List.empty(growable: true).obs;

  var isCityEnabled = false.obs;

  var startDateController = TextEditingController().obs;
  var endDateController = TextEditingController().obs;
  var noteController = TextEditingController();

  var address = ''.obs;
  var pic = ''.obs;
  var picRole = ''.obs;
  var picPhone = ''.obs;

  var idCompanyCity = 0.obs;
  List<dynamic> _apiDataCompany = [];
  List<dynamic> _apiDataCity = [];
  List<dynamic> _apiDataAllCity = [];
  List<dynamic> _apiDataAllUser = [];

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchCompanyItems();
    await fetchAllCityItems();
    await fetchAllUserItems();
  }

  Future<void> fetchCompanyItems() async {
    isLoading.value = true;
    _apiDataCompany = await _companyRepository.fetchCompany();
    companyItem.value =
        _apiDataCompany.map((item) => item['name'].toString()).toSet().toList();
    if (companyItem.isNotEmpty) {
      fetchCompanyCityItems();
      updateCityItems(selectedCompany.value);
    }
  }

  Future<void> fetchAllCityItems() async {
    _apiDataAllCity = await _cityRepository.fetchCity();
    allCityItem.value =
        _apiDataAllCity.map((item) => item['name'].toString()).toSet().toList();
  }

  Future<void> fetchAllUserItems() async {
    _apiDataAllUser = await _userRepository.fetchAllUser();
    allUserItem.value = _apiDataAllUser
        .map((item) => item['full_name'].toString())
        .toSet()
        .toList();
    log(_apiDataAllUser.toString());
    isLoading.value = false;
  }

  Future<void> fetchCompanyCityItems() async {
    _apiDataCity = await _companyRepository.fetchCompanyCity();
    log(_apiDataCity.toString());
  }

  Future<dynamic> postBusinessTrip() async {
    try {
      final trip = await _businessTripRepository.postTrip(
        idCompanyCity: idCompanyCity.value,
        departure: selectedAllCity.value,
        startDate: startDateController.value.text,
        endDate: endDateController.value.text,
        note: noteController.text,
      );

      final responseData = trip;
      log('Business trip ID: ${responseData['data']['id']}');
      return responseData['data']['id'];
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> postTripDetail(int businessTripId) async {
    try {
      final success = await _businessTripRepository.postTripDetail(
        idTrip: businessTripId,
        employeeList: employeeList.map((employee) => employee.id).toList(),
      );

      if (success) {
        log('success create trip detail');
      } else {
        log('Error Failed create trip detail');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
    }
  }

  void updateCityItems(String company) {
    log('update city items');
    selectedCity.value = '';
    clearCityRelatedData();

    var filteredData =
        _apiDataCity.where((item) => item['company_name'] == company).toList();

    cityItem.value =
        filteredData.map((item) => item['city_name'].toString()).toList();

    isCityEnabled.value = cityItem.isNotEmpty;
    log('City Items: $cityItem');
  }

  void clearCityRelatedData() {
    address.value = '';
    pic.value = '';
    picRole.value = '';
    picPhone.value = '';
  }

  void updateCityRelatedData(String company, String city) {
    var data = _apiDataCity.firstWhere(
      (item) => item['company_name'] == company && item['city_name'] == city,
      orElse: () => null,
    );

    log('data relate :$data');

    if (data != null) {
      address.value = data['address'].toString();
      pic.value = data['pic'].toString();
      picRole.value = data['pic_role'].toString();
      picPhone.value = data['pic_phone'].toString();
      idCompanyCity.value = data['id']; // Menyimpan id_company_city
    } else {
      clearCityRelatedData();
    }
  }

  void addEmployeeToList() {
    if (employeeList.length < 2) {
      if (selectedAllUser.isEmpty) {
        Get.snackbar('Error', 'Mohon pilih employee terlebih dahulu');
      } else if (!employeeList
          .any((employee) => employee.fullName == selectedAllUser.value)) {
        var selectedUser = _apiDataAllUser
            .firstWhere((user) => user['full_name'] == selectedAllUser.value);
        employeeList.add(EmployeeName(
            id: selectedUser['id'], fullName: selectedAllUser.value));
        log('Added Employee: ${selectedAllUser.value}, ID: ${selectedUser['id']}');
      } else {
        Get.snackbar('Error', 'Employee sudah ada dalam list');
      }
    } else {
      Get.snackbar('Error', 'Maksimal hanya bisa menambah 2 orang');
    }
    update();
  }

  void removeEmployee(EmployeeName employee) {
    employeeList.remove(employee);
    update();
  }
}
