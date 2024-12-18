import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/controllers/change_password_page_controller.dart';
import 'package:nextbasis_hris/widgets/appbars/build_appbar.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';
import 'package:nextbasis_hris/widgets/fields/build_field_text.dart';

class ChangePasswordPage extends GetView<ChangePasswordPageController> {
  const ChangePasswordPage({super.key});

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
                            controller: controller.currentPasswordController,
                            required: true,
                            obscureText: true,
                            title: 'Current Password',
                          ),
                          BuildFieldText(
                            controller: controller.newPasswordController,
                            required: true,
                            obscureText: true,
                            title: 'New Password',
                          ),
                          BuildFieldText(
                            controller: controller.confirmPasswordController,
                            required: true,
                            obscureText: true,
                            title: 'Re-enter new password',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BuildButton(
              title: 'Confirm',
              onPressed: controller.changePassword,
            ),
          ],
        ),
      ),
    );
  }
}

