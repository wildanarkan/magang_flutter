import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

class LoginController extends GetxController {
  // Repository
  final UserRepository _userRepository = UserRepository();

  final edtUsername = TextEditingController().obs;
  final edtPassword = TextEditingController().obs;
  final storage = GetStorage();
  RxBool isLoading = false.obs;

  void resetFields() {
    edtUsername.value.clear();
    edtPassword.value.clear();
  }

  void logout() async {
    final userId = storage.read('userId');
    final token = storage.read('accessToken');

    try {
      // Kirim permintaan untuk menghapus token FCM dari server
      final isDeleted = await _userRepository.deleteFcmToken(userId, token);
      if (!isDeleted) {
        log('Failed to delete FCM token');
      }
    } catch (e) {
      log('Error while deleting FCM token: $e');
    } finally {
      // Hapus data dari GetStorage dan reset field
      await GetStorage().erase();
      resetFields();
      Get.deleteAll();
      Get.offAllNamed('/login');
      Get.snackbar('Success', backgroundColor: AppColor.success, 'Berhasil Logout');
    }
  }

  Future<SnackbarController> login() async {
    final username = edtUsername.value.text.trim();
    final password = edtPassword.value.text.trim();

    if (username == '' || password == '') {
      return Get.snackbar('Failed', backgroundColor: AppColor.failed, 'Lengkapi username dan password');
    }

    try {
      isLoading.value = true;

      final model = await _userRepository.login(username, password);
      if (model.accessToken != null) {
        await storage.write('accessToken', model.accessToken);
        await storage.write('email', model.user!.email);
        storage.write('userId', model.user!.id.toString());
        print('Semua data di GetStorage:');
        storage.getKeys().forEach((key) {
          log('$key: ${storage.read(key)}');
        });
        resetFields();
        Get.toNamed(AppRoutes.otp);
        return Get.snackbar('Success', backgroundColor: AppColor.success, 'Check email anda untuk Code OTP');
      }
      return Get.snackbar('Failed', backgroundColor: AppColor.failed, 'Terjadi Keselahan');
    } catch (e) {
      log(e.toString());
      if (e.toString().contains('401')) {
        return Get.snackbar('Failed', backgroundColor: AppColor.failed, 'Username dan password tidak cocok');
      } else if (e.toString().contains('403')) {
        return Get.snackbar(
            'Error', 'Karyawan tidak aktif. Silakan hubungi admin.');
      } else {
        return Get.snackbar('Error', backgroundColor: AppColor.error, 'Terjadi kesalahan: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
