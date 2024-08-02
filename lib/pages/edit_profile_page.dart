import 'package:flutter/material.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        const BuildTextField(
                          title: 'First Name',
                        ),
                        const BuildTextField(
                          title: 'Last Name',
                        ),
                        const BuildTextField(
                          title: 'Phone Number',
                        ),
                        const BuildTextField(
                          title: 'kota',
                        ),
                        const BuildTextField(
                          title: 'Address',
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        BuildButton(
                          context: context,
                          title: 'Confirm',
                          onPressed: () {
                            Navigator.pop(context);
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
