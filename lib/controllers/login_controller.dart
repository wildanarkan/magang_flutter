import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

class LoginController extends GetxController {
  final edtUsername = TextEditingController().obs;
  final edtPassword = TextEditingController().obs;
  final storage = GetStorage();

  void resetFields() {
    edtUsername.value.clear();
    edtPassword.value.clear();
  }

  void logout() async {
    await GetStorage().erase();
    resetFields();
    Get.deleteAll();
    Get.offAllNamed('/login');
  }

  Future<void> login() async {
    final username = edtUsername.value.text.trim();
    final password = edtPassword.value.text.trim();

    try {
      final model = await UserRepository().login(username, password);
      if (model.accessToken != null) {
        await storage.write('accessToken', model.accessToken);
        await storage.write('email', model.user!.email);
        storage.write('userId', model.user!.id.toString());
        print('Semua data di GetStorage:');
        storage.getKeys().forEach((key) {
          log('$key: ${storage.read(key)}');
        });
        Get.toNamed(AppRoutes.otp);
      } else {
        Get.snackbar('Failed',
            'Login gagal, Silakan cek kembali email dan password Anda.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {}
  }
}
