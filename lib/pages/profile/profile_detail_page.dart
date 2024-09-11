import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/pages/profile/change_password_page.dart';
import 'package:magang_flutter/pages/profile/edit_profile_page.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/buttons/build_button.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorPageControllers controller =
        Get.find<NavigatorPageControllers>();

    return Scaffold(
      body: ListView(
        children: [
          const BuildAppbar(
            title: 'Profile Detail',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Personal Information',
                              style: TextStyle(color: AppColor.textBody),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const EditProfilePage());
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'First Name',
                                    style: TextStyle(color: AppColor.textBody),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.firstName.value,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Last Name',
                                    style: TextStyle(color: AppColor.textBody),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.lastName.value,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gender',
                                    style: TextStyle(color: AppColor.textBody),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.gender.value,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Religion',
                                    style: TextStyle(color: AppColor.textBody),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.religion.value,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Role',
                                    style: TextStyle(color: AppColor.textBody),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.role.value,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Employee Group',
                                    style: TextStyle(color: AppColor.textBody),
                                  ),
                                  Obx(
                                    () => Text(
                                      '${controller.employee_group.value}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Contact',
                          style:
                              TextStyle(fontSize: 16, color: AppColor.textBody),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Phone Number',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                            controller.phone_number.value,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Address',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                            '${controller.city.value}, ${controller.address.value}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                            controller.email.value,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Other Information',
                          style:
                              TextStyle(fontSize: 16, color: AppColor.textBody),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'NIP',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                            '${controller.nip.value}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'NIK',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                            '${controller.nik.value}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                BuildButton(
                  context: context,
                  title: 'Change Password',
                  onPressed: () {
                    Get.to(() => ChangePasswordPage());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
