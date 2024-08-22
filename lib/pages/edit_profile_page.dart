import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

import '../controllers/edit_profile_page_controller.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfilePageController controller =
        Get.put(EditProfilePageController());

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const BuildTestAppbar(
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
                        BuildTextField(
                          title: 'First Name',
                          controller: controller.firstNameController,
                          onChanged: (value) =>
                              controller.firstName.value = value,
                        ),
                        BuildTextField(
                          title: 'Last Name',
                          controller: controller.lastNameController,
                          onChanged: (value) =>
                              controller.lastName.value = value,
                        ),
                        BuildTextField(
                          title: 'Phone Number',
                          controller: controller.phoneNumberController,
                          onChanged: (value) =>
                              controller.phoneNumber.value = value,
                        ),
                        BuildTextField(
                          title: 'City',
                          controller: controller.cityController,
                          onChanged: (value) => controller.city.value = value,
                        ),
                        BuildTextField(
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
                              Get.find<NavigatorPageControllers>()
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
