import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/change_password_page.dart';
import 'package:magang_flutter/pages/edit_profile_page.dart';
import 'package:magang_flutter/widgets/build_appbar.dart';
import 'package:magang_flutter/widgets/build_button.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          BuildAppbar(
            context: context,
            title: 'Profile Detail',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage(),));
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'First Name',
                                  style: TextStyle(color: AppColor.textBody),
                                ),
                                const Text(
                                  'arya',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Gender',
                                  style: TextStyle(color: AppColor.textBody),
                                ),
                                const Text(
                                  'male',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Last Name',
                                  style: TextStyle(color: AppColor.textBody),
                                ),
                                const Text(
                                  'putra',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Religion',
                                  style: TextStyle(color: AppColor.textBody),
                                ),
                                const Text(
                                  'islam',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 19,
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 19,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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
                        const Text(
                          '089562788181',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                        const Text(
                          'jl. sinobodododo',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                        const Text(
                          'admin@gmail.com',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                          'Nomor Induk',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          '089562788181',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100,),
                BuildButton(context: context, title: 'Change Password', onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage(),)); },)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
