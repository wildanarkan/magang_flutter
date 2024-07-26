import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magang_flutter/data/repo/user_repository.dart';
import 'package:magang_flutter/pages/navigator_page.dart';

class LoginPageController extends GetxController {
  final edtEmail = TextEditingController().obs;
  final edtPassword = TextEditingController().obs;

  Future<void> login() async {
    final email = edtEmail.value.text;
    final password = edtPassword.value.text;

    final token = await UserRepository().login(email, password);

    if (token != null) {
      GetStorage().write('accessToken', token);
      Get.offAll(() => const NavigatorPage());
    } else {
      print('Login gagal');
    }
  }
}
