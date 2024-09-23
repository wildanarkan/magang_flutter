import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

class CodeOtpController extends GetxController {
  // Repository
  final UserRepository _userRepository = UserRepository();

  // Storage
  final storage = GetStorage();

  // TextEditingController
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();

  // Countdown timer
  RxInt secondsRemaining = 300.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> verifyOtp() async {
    String otp = controller1.text +
        controller2.text +
        controller3.text +
        controller4.text +
        controller5.text +
        controller6.text;

    try {
      final success = await _userRepository.verifyOtp(storage.read('email'), otp);
      if (success) {
        await storage.write('isLoggedIn', true);
        print('Semua data di GetStorage:');
        storage.getKeys().forEach((key) {
          log('$key: ${storage.read(key)}');
        });
        Get.offAllNamed(AppRoutes.navigator);
      } else {
        Get.snackbar('Failed',
            'Login gagal, Silakan cek kembali email dan password Anda.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {}
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    secondsRemaining.value = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  String getFormattedTime() {
    int minutes = secondsRemaining.value ~/ 60;
    int seconds = secondsRemaining.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void resetField() {
    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();
    controller5.clear();
    controller6.clear();
    update();
    log(controller1.text);
    log(controller2.text);
    log(controller3.text);
    log(controller4.text);
    log(controller5.text);
    log(controller6.text);
  }

  void printField() {
    String otp = controller1.text +
        controller2.text +
        controller3.text +
        controller4.text +
        controller5.text +
        controller6.text;
    print('Entered OTP: $otp');
  }

  String obscureEmail() {
    final email = storage.read('email');
    final atIndex = email.indexOf('@');
    if (atIndex > 2) {
      return '${email.substring(0, 2)}${'*' * (atIndex - 3)}${email.substring(atIndex - 2)}${email.substring(atIndex)}';
    }
    return email;
  }
}
