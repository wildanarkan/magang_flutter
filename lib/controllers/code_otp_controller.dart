import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';
import 'package:nextbasis_hris/widgets/dialogs/build_dialog_confirmation.dart';

class CodeOtpController extends GetxController {
  // Repository
  final UserRepository _userRepository = UserRepository();

  // Storage
  final storage = GetStorage();

  // TextEditingController
  var otpController = TextEditingController();

  // Countdown timer
  RxInt secondsRemaining = 180.obs;
  Timer? _timer;

  // Loading state
  RxBool isLoading = false.obs;

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

  Future<SnackbarController> verifyOtp() async {
    if (otpController.text.length != 6) {
      return Get.snackbar('Failed', 'Please fill Code OTP');
    }
    try {
      isLoading.value = true;
      final success = await _userRepository.verifyOtp(
          storage.read('email'), otpController.text);
      otpController.clear();
      if (success) {
        await storage.write('isLoggedIn', true);
        print('Semua data di GetStorage:');
        storage.getKeys().forEach((key) {
          log('$key: ${storage.read(key)}');
        });
        Get.offAllNamed(AppRoutes.navigator);
        return Get.snackbar('Success', 'Code OTP Valid');
      } else {
        return Get.snackbar('Failed', 'Code OTP Invalid Or Expired');
      }
    } catch (e) {
      return Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<SnackbarController> sendOtp() async {
    try {
      if (secondsRemaining.value != 0) {
        return Get.snackbar('Failed', 'Wait for a minute!');
      }
      isLoading.value = true;
      final success = await _userRepository.sendOtp();
      if (success) {
        startTimer();
        return Get.snackbar('Success', 'Code OTP send to your email');
      }
      return Get.snackbar('Failed', 'Code OTP Invalid Or Expired');
    } catch (e) {
      return Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    secondsRemaining.value = 180;
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
    otpController.clear();
    update();
    log(otpController.text);
  }

  void printField() {
    print('Entered OTP: ${otpController.text}');
  }

  String obscureEmail() {
    final email = storage.read('email');
    final atIndex = email.indexOf('@');
    if (atIndex > 2) {
      return '${email.substring(0, 2)}${'*' * (atIndex - 3)}${email.substring(atIndex - 1)}';
    }
    return email;
  }

  Future<bool> exitDialog(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => BuildDialogConfirmation(
        title: 'Confirm Exit',
        message: 'Are you sure you want to close this page?',
        onConfirm: () {
          Get.back(result: true);
        },
        onCancel: () {
          Get.back(closeOverlays: true, result: false);
        },
      ),
    );
    return result ??
        false;
  }
}
