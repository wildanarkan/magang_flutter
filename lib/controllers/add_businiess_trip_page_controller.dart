import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBusiniessTripPageController extends GetxController {

  final List<DropdownMenuItem<String>> companyItem = [
    const DropdownMenuItem(value: 'PT. BELUM BUKA', child: Text('PT. BELUM BUKA')),
    const DropdownMenuItem(value: 'PT. SIDOMUNCUL', child: Text('PT. SIDOMUNCUL')),
    const DropdownMenuItem(value: 'PT. JAYA ABADI', child: Text('PT. JAYA ABADI')),
  ];

  // Declare the selectedCompany variable as late
  late String selectedCompany;

  Rx<TextEditingController> dateController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the selectedCompany variable
    selectedCompany = 'PT. BELUM BUKA';
  }
}
