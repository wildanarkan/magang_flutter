import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';

class EditProfilePageController extends GetxController {
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString city = ''.obs;
  RxString address = ''.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    
    // Ambil data dari NavigatorPageControllers
    final navigatorController = Get.find<NavigatorPageControllers>();
    firstName.value = navigatorController.firstName.value;
    lastName.value = navigatorController.lastName.value;
    phoneNumber.value = navigatorController.phone_number.value;
    city.value = navigatorController.city.value;
    address.value = navigatorController.address.value;

    // Set nilai TextEditingController sesuai data yang diambil
    firstNameController.text = firstName.value;
    lastNameController.text = lastName.value;
    phoneNumberController.text = phoneNumber.value;
    cityController.text = city.value;
    addressController.text = address.value;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    cityController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<bool> editProfile() async {
    try {
      final token = GetStorage().read('accessToken');
      final response = await http.post(
        Uri.parse(URLs.editprofile),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          'first_name': firstName.value,
          'last_name': lastName.value,
          'phone_number': phoneNumber.value,
          'city': city.value,
          'address': address.value,
        }),
      );

      if (response.statusCode == 200) {
        firstName.value = firstNameController.text;
        lastName.value = lastNameController.text;
        phoneNumber.value = phoneNumberController.text;
        city.value = cityController.text;
        address.value = addressController.text;
        
        // Get.snackbar('Success', 'Profile updated successfully');
        update(); // Notify listeners to update the UI
        return true;
      } else {
        Get.snackbar('Error', 'Failed to update profile: ${response.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return false;
    }
  }
}
