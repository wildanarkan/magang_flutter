import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';

class ChangePasswordPageController extends GetxController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var isLoading = false.obs;

  void resetFields() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> changePassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      // Tampilkan pesan kesalahan jika kata sandi baru dan konfirmasi tidak cocok
      Get.snackbar(
        'Error',
        'New Password and Confirm Password do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final token = GetStorage().read('accessToken');
    isLoading.value = true;

    final response = await http.post(
      Uri.parse(URLs.changePassword),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'current_password': currentPasswordController.text,
        'new_password': newPasswordController.text,
        'new_password_confirmation': confirmPasswordController.text,
      }),
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      print('succes');
      resetFields();
      Get.snackbar(
        'Success',
        'Password successfully changed',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      print('gagal');
      Get.snackbar(
        'Error',
        'Failed to change password',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
