import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeOtpController extends GetxController {
  // TextEditingController
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();

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
    log(controller1.text);
    log(controller2.text);
    log(controller3.text);
    log(controller4.text);
    log(controller5.text);
    log(controller6.text);
  }

  String obscureEmail(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex > 2) {
      return '${email.substring(0, 2)}${'*' * (atIndex - 3)}${email.substring(atIndex - 2)}${email.substring(atIndex)}';
    }
    return email; // Jika email tidak cukup panjang, kembalikan seperti aslinya
  }
}
