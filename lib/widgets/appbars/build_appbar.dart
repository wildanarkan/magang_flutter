import 'package:flutter/material.dart';
import 'package:nextbasis_hris/common/app_color.dart';

class BuildAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BuildAppbar(
      {super.key,
      required this.title,
      this.actions = const [],
      this.paddingTitle});

  final String title;
  final EdgeInsetsGeometry? paddingTitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Padding(
        padding: paddingTitle ?? const EdgeInsets.all(0),
        child: Text(
          title,
          style: TextStyle(
            color: AppColor.textTitle,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(50); // Adjust height as needed
}
