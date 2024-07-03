import 'package:flutter/material.dart';
import 'package:magang_flutter/widgets/build_appbar.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

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
                  child: const Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       BuildTextField(
                         title: 'First Name',),
                         BuildTextField(
                         title: 'Last Name',),
                        BuildTextField(
                         title: 'Phone Number',),
                        BuildTextField(
                         title: 'kota',),
                        BuildTextField(
                         title: 'Address',),
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
