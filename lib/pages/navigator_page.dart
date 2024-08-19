import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/controllers/profile_page_controller.dart';
import 'package:magang_flutter/widgets/fab_bottom_app_bar.dart';

class NavigatorPage extends StatelessWidget {
  const NavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfilePageController());
    final controller = Get.put(NavigatorPageControllers());

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

  Widget bottomNavigator(NavigatorPageControllers controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 81,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FABBottomAppBar(
              selectedColor: AppColor.textTitle,
              selectedIndex: controller.selectedPage.value,
              onTabSelected: (index) {
                controller.changePage(index);
              },
              items: [
                FABBottomAppBarItem(iconPage: Icons.home, title: 'Home'),
                FABBottomAppBarItem(
                    iconPage: Icons.card_travel_rounded,
                    title: 'Business Trip'),
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
