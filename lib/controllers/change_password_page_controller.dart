import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

class ChangePasswordPageController extends GetxController {
  // Repository
  final UserRepository _userRepository = Get.find<UserRepository>();

  // Text Editing Controller
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void resetFields() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> changePassword() async {
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', backgroundColor: AppColor.error, 'Please fill all data');
      return;
    }

    if (newPasswordController.text.length < 8) {
      Get.snackbar('Error', backgroundColor: AppColor.error, 'New Password must be at least 8 characters long');
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', backgroundColor: AppColor.error, 'New Password and Confirm Password do not match');
      return;
    }

    try {
      final success = await _userRepository.changePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (success) {
        resetFields();
        Get.snackbar('Success', backgroundColor: AppColor.success, 'Password successfully changed');
      }
    } catch (e) {
      Get.snackbar('Error', backgroundColor: AppColor.error, e.toString().replaceFirst('Exception: ', ''));
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
