import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_appbar.dart';
import 'package:magang_flutter/widgets/build_button.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          BuildAppbar(
            context: context,
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
                        Text(
                          'First Name',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none
                          ),
                        ),
                        const SizedBox(height: 5,),
                         Text(
                          'Last Name',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none
                          ),
                        ),
                        const SizedBox(height: 5,),
                         Text(
                          'Phone Number',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none
                          ),
                        ),
                        const SizedBox(height: 5,),
                         Text(
                          'Kota',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none
                          ),
                        ),
                        const SizedBox(height: 5,),
                         Text(
                          'Address',
                          style: TextStyle(color: AppColor.textBody),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                BuildButton(context: context, title: 'Confirm', onPressed: () { Navigator.pop(context); },)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
