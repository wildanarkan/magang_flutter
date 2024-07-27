import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/pages/contract_history_page.dart';
import 'package:magang_flutter/pages/leave_history_page.dart';
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
                                          controller.userName.value,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'HRD',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.textBody),
                                    )
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileDetailPage(),
                                    ),
                                  );
                                },
                              ),
                              BuildRowicon(
                                icon: Icons.personal_injury_sharp,
                                iconColor: AppColor.primary,
                                title: 'Leave History',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LeaveHistoryPage(),
                                    ),
                                  );
                                },
                              ),
                              BuildRowicon(
                                icon: Icons.account_balance_wallet,
                                iconColor: AppColor.primary,
                                title: 'Payroll History',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PayrollHistoryPage(),
                                    ),
                                  );
                                },
                              ),
                              BuildRowicon(
                                icon: Icons.contact_mail_outlined,
                                iconColor: AppColor.primary,
                                title: 'Contract History',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ContractHistoryPage(),
                                    ),
                                  );
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
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Obx(
                            () => controller.profilePhotoUrl.value.isNotEmpty
                                ? Image.network(
                                    controller.profilePhotoUrl.value,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/background.png', // Gambar default jika tidak ada foto profil
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
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
