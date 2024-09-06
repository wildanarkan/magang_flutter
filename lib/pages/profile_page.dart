import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/home_page_controller.dart';
import 'package:magang_flutter/controllers/login_page_controller.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/controllers/profile_page_controller.dart';
import 'package:magang_flutter/pages/contract_history_page.dart';
import 'package:magang_flutter/pages/payroll_history_page.dart';
import 'package:magang_flutter/pages/profile_detail_page.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_rowicon.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorPageControllers controller =
        Get.find<NavigatorPageControllers>();
    final LoginPageController loginController = Get.find<LoginPageController>();
    final ProfilePageController profileController =
        Get.find<ProfilePageController>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/blue_background.png'),
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.only(
                top: 25, bottom: 120, left: 25, right: 25),
            children: [
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 25),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(() => Text(
                                          '${controller.firstName.value} ${controller.lastName.value}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.role.value,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.textBody),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Divider(),
                              BuildRowicon(
                                icon: Icons.contact_page_sharp,
                                iconColor: AppColor.primary,
                                title: 'Detail',
                                onTap: () {
                                  Get.to(() => const ProfileDetailPage());
                                },
                              ),
                              BuildRowicon(
                                icon: Icons.account_balance_wallet,
                                iconColor: AppColor.primary,
                                title: 'Payroll History',
                                onTap: () {
                                  Get.to(() => const PayrollHistoryPage());
                                },
                              ),
                              BuildRowicon(
                                icon: Icons.contact_mail_outlined,
                                iconColor: AppColor.primary,
                                title: 'Contract History',
                                onTap: () {
                                  Get.to(() => const ContractHistoryPage());
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      BuildButton(
                        context: context,
                        title: 'Logout',
                        backgroundColor: Colors.white,
                        foregroundColor: AppColor.decline,
                        borderColor: AppColor.decline,
                        width: 320,
                        onPressed: () {
                          final HomePageController homePageController =
                              Get.find<HomePageController>();
                          homePageController.savedBusinessTrips.clear();
                          print(homePageController.savedBusinessTrips.length);

                          loginController.logout();
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          profileController.updateProfilePhoto();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 30),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Obx(
                              () => CachedNetworkImage(
                                height: 80,
                                width: 80,
                                imageUrl:
                                    '${URLs.photoUrl}${controller.profilePhotoUrl.value}',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
