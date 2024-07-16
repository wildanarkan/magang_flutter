import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBusiniessTripPageController extends GetxController {

  final List<String> companyItem = [
    'PT. BELUM BUKA',
    'PT. SIDOMUNCUL',
    'PT. JAYA ABADI',
  ].obs;

  // Declare the selectedCompany variable as late
  late RxString selectedCompany;

  Rx<TextEditingController> dateController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the selectedCompany variable
    selectedCompany = 'PT. BELUM BUKA'.obs;
  }
}
