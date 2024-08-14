import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magang_flutter/data/repo/user_repository.dart';
import 'package:magang_flutter/pages/login_page.dart';
import 'package:magang_flutter/pages/navigator_page.dart';

class LoginPageController extends GetxController {
  final edtEmail = TextEditingController().obs;
  final edtPassword = TextEditingController().obs;
  final storage = GetStorage();

  void resetFields() {
    edtEmail.value.clear();
    edtPassword.value.clear();
  }

  void logout() {
    storage.remove('accessToken');
    storage.remove('userId');
    storage.write('isLoggedIn', false); // Set isLoggedIn ke false saat logout
    resetFields();
    Get.offAll(() => const LoginPage());
  }

  Future<void> login() async {
    final email = edtEmail.value.text.trim();
    final password = edtPassword.value.text.trim();

    try {
      final token = await UserRepository().login(email, password);
      if (token != null) {
        
        storage.write('accessToken', token);
        storage.write('isLoggedIn', true); // Set isLoggedIn ke true saat login berhasil
        Get.offAll(() => const NavigatorPage());
      } else {
        Get.snackbar('Error', 'Login gagal. Silakan cek kembali email dan password Anda.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}
