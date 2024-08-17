import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildAppbar extends StatelessWidget {
  const BuildAppbar({
    super.key,
    required this.context, required this.title,
  });

  final String title;

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      centerTitle: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                BackButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: Colors.black),
                 Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}