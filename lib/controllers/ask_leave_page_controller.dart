import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AskLeavePageController extends GetxController {

  final List<String> companyItem = [
    'Cuti Tahunan',
    'Cuti Bulanan',
    'Cuti Mingguan',
    'Cuti Harian',
  ].obs;

  late RxString selectedCompany;

  Rx<TextEditingController> startDateController = TextEditingController().obs;
  Rx<TextEditingController> endDateController = TextEditingController().obs;


  @override
  void onInit() {
    super.onInit();
    selectedCompany = 'Cuti Tahunan'.obs;
  }
}