import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/controllers/navigator_controllers.dart';
import 'package:nextbasis_hris/controllers/profile_update_controller.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';
import 'package:nextbasis_hris/widgets/fields/build_field_text.dart';

class ProfileUpdatePage extends GetView<ProfileUpdateController> {
  const ProfileUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppbar(title: 'Change Password'),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(AppComponent.marginPage),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          BuildFieldText(
                            required: true,
                            title: 'First Name',
                            controller: controller.firstNameController,
                            onChanged: (value) =>
                                controller.firstName.value = value,
                          ),
                          BuildFieldText(
                            required: true,
                            title: 'Last Name',
                            controller: controller.lastNameController,
                            onChanged: (value) =>
                                controller.lastName.value = value,
                          ),
                          BuildFieldText(
                            required: true,
                            title: 'Phone Number',
                            inputType: TextInputType.number,
                            controller: controller.phoneNumberController,
                            onChanged: (value) =>
                                controller.phoneNumber.value = value,
                          ),
                          BuildFieldText(
                            required: true,
                            title: 'City',
                            controller: controller.cityController,
                            onChanged: (value) => controller.city.value = value,
                          ),
                          BuildFieldText(
                            required: true,
                            title: 'Address',
                            controller: controller.addressController,
                            onChanged: (value) =>
                                controller.address.value = value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BuildButton(
              context: context,
              title: 'Confirm',
              onPressed: () async {
                final success = await controller.editProfile();
                if (success) {
                  // Update data di NavigatorPageControllers
                  Get.find<NavigatorControllers>().fetchUserData();
                  log('get back');
                  Get.back(); // Menggunakan Navigator.pop
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
