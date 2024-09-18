import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/controllers/navigator_controllers.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/buttons/build_button.dart';
import 'package:magang_flutter/widgets/fields/build_field_text.dart';

import '../../controllers/profile_update_controller.dart';

class ProfileUpdatePage extends GetView<ProfileUpdateController> {
  const ProfileUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const BuildAppbar(
            title: 'Edit Profile',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildFieldText(
                          title: 'First Name',
                          controller: controller.firstNameController,
                          onChanged: (value) =>
                              controller.firstName.value = value,
                        ),
                        BuildFieldText(
                          title: 'Last Name',
                          controller: controller.lastNameController,
                          onChanged: (value) =>
                              controller.lastName.value = value,
                        ),
                        BuildFieldText(
                          title: 'Phone Number',
                          inputType: TextInputType.number,
                          controller: controller.phoneNumberController,
                          onChanged: (value) =>
                              controller.phoneNumber.value = value,
                        ),
                        BuildFieldText(
                          title: 'City',
                          controller: controller.cityController,
                          onChanged: (value) => controller.city.value = value,
                        ),
                        BuildFieldText(
                          title: 'Address',
                          controller: controller.addressController,
                          onChanged: (value) =>
                              controller.address.value = value,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        BuildButton(
                          context: context,
                          title: 'Confirm',
                          onPressed: () async {
                            final success = await controller.editProfile();
                            if (success) {
                              // Update data di NavigatorPageControllers
                              Get.find<NavigatorControllers>()
                                  .fetchUserData();
                              log('get back');
                              Get.back(); // Menggunakan Navigator.pop
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
