import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/navigator_controllers.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

class ProfileUpdateController extends GetxController {
  // Controller
  final navigatorController = Get.find<NavigatorControllers>();

  // Repository
  final UserRepository _userRepository = Get.find<UserRepository>();

  // Variable
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString city = ''.obs;
  RxString address = ''.obs;

  // Text Editing Controller
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    firstName.value = navigatorController.firstName.value;
    lastName.value = navigatorController.lastName.value;
    phoneNumber.value = navigatorController.phone_number.value;
    city.value = navigatorController.city.value;
    address.value = navigatorController.address.value;

    firstNameController.text = firstName.value;
    lastNameController.text = lastName.value;
    phoneNumberController.text = phoneNumber.value;
    cityController.text = city.value;
    addressController.text = address.value;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    cityController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<bool> editProfile() async {
    try {
      final success = await _userRepository.editProfile(
        firstName: firstName.value,
        lastName: lastName.value,
        phoneNumber: phoneNumber.value,
        city: city.value,
        address: address.value,
      );

      if (success) {
        firstName.value = firstNameController.text;
        lastName.value = lastNameController.text;
        phoneNumber.value = phoneNumberController.text;
        city.value = cityController.text;
        address.value = addressController.text;

        Get.snackbar('Success', 'Profile updated successfully');

        await Future.delayed(const Duration(seconds: 1));
        Navigator.pop(Get.context!);
      }

      return success;
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }
}
