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

  void logout() async {
    await GetStorage().erase();
    resetFields();
    Get.deleteAll();
    Get.lazyPut(() => LoginPageController());
    Get.offAll(() => const LoginPage());
  }

  Future<void> login() async {
    final email = edtEmail.value.text.trim();
    final password = edtPassword.value.text.trim();

    try {
      final token = await UserRepository().login(email, password);
      if (token != null) {
        await storage.write('accessToken', token);
        await storage.write('isLoggedIn', true);
        // Cetak semua data di GetStorage
        print('Semua data di GetStorage:');
        storage.getKeys().forEach((key) {
          print('$key: ${storage.read(key)}');
        });
        Get.offAll(() => const NavigatorPage());
      } else {
        Get.snackbar('Failed',
            'Login gagal, Silakan cek kembali email dan password Anda.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {}
  }
}
