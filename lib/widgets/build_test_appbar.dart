import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildTestAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BuildTestAppbar(
      {super.key, required this.title, this.actions = const []});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
          color: AppColor.textTitle,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(50); // Adjust height as needed
}
