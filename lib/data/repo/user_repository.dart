import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/data/models/login_model.dart';

class UserRepository extends GetxService {
  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(URLs.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final loginModel = LoginModel.fromJson(data);
        final fullname = '${loginModel.result!.user!.firstName!} ${loginModel.result!.user!.lastName!}';
        Get.snackbar('Success', 'Login berhasil selamat datang $fullname');
        log(fullname);
        return loginModel.result?.accessToken; 
      } else {
        print('Login failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error Login: $e');
      return null;
    }
  }
}
