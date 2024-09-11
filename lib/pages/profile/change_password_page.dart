import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/change_password_page_controller.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/buttons/build_button.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final ChangePasswordPageController controller = Get.put(ChangePasswordPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const BuildAppbar(
            title: 'Change Password',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Password',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: AppColor.inputBackground),
                          child: TextField(
                            controller: controller.currentPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: AppColor.textBody),
                                hintText: 'Enter Password',
                                isDense: true,
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'New Password',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: AppColor.inputBackground),
                          child: TextField(
                            controller: controller.newPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: AppColor.textBody),
                                hintText: 'Enter Password',
                                isDense: true,
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Re-enter New Password',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: AppColor.inputBackground),
                          child: TextField(
                            controller: controller.confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: AppColor.textBody),
                                hintText: 'Enter Password',
                                isDense: true,
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 200),
                BuildButton(
                  context: context,
                  title: 'Confirm',
                  onPressed: controller.changePassword,
                ),
                if (controller.isLoading.value)
                  const CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
