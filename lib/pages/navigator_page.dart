import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/controllers/navigator_controllers.dart';
import 'package:nextbasis_hris/widgets/fab_bottom_app_bar.dart';

class NavigatorPage extends GetView<NavigatorControllers> {
  const NavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            IndexedStack(
              index: controller.selectedPage.value,
              children: controller.page,
            ),
            bottomNavigator(controller),
          ],
        ),
      ),
    );
  }

  Widget bottomNavigator(NavigatorControllers controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin:  const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FABBottomAppBar(
              selectedColor: AppColor.textTitle,
              selectedIndex: controller.selectedPage.value,
              iconSize: 1,
              height: 1,
              onTabSelected: (index) {
                controller.changePage(index);
              },
              items: [
                FABBottomAppBarItem(iconPage: Icons.home, title: 'Home'),
                FABBottomAppBarItem(
                    iconPage: Icons.card_travel_rounded,
                    title: 'Business Trip',),
                FABBottomAppBarItem(
                    iconPage: Icons.time_to_leave,
                    title: 'Leave'),
                FABBottomAppBarItem(iconPage: Icons.person, title: 'Profile'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
