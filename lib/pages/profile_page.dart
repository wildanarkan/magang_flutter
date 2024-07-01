import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/contract_history_page.dart';
import 'package:magang_flutter/pages/leave_history_page.dart';
import 'package:magang_flutter/pages/payroll_history_page.dart';
import 'package:magang_flutter/pages/profile_detail_page.dart';
import 'package:magang_flutter/widgets/build_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          BuildAppbar(
            context: context,
            title: 'Profile',
          ),
          Stack(
            children: [
              header(),
              const SizedBox(height: 30),

              // Uncomment and adjust as needed for additional menu items
              Positioned(
                top: 250, // Adjust the top position as needed
                left: 30,
                right: 30,
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ProfileDetailPage(),
                            ),
                          );
                        },
                        child: buildItemMenu(Icons.contact_page, 'Detail')),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LeaveHistoryPage(),
                            ),
                          );
                        },
                      child: buildItemMenu(Icons.personal_injury_sharp, 'Leave History')),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const PayrollHistoryPage(),
                            ),
                          );
                      },
                      child: buildItemMenu(Icons.account_balance_wallet_rounded,
                          'Payroll History'),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                       onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ContractHistoryPage(),
                            ),
                          );
                      },
                      child: buildItemMenu(
                          Icons.contact_mail_outlined, 'Contract History'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Stack(
      children: [
        Positioned(
          child: Container(
            height: 200, // Adjust the height as needed
            color: AppColor.primary,
            margin: const EdgeInsets.only(bottom: 350),
          ),
        ),
        Positioned(
          top: 100, // Adjust the top position as needed
          left: 30,
          right: 30,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  'JOKO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.textTitle,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'EMAIL',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: AppColor.textBody,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 50),
                // buildItemMenu(Icons.edit, 'Edit Profile'), // Moved to the main stack
              ],
            ),
          ),
        ),
        Positioned(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black38,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/logo.png',
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItemMenu(IconData icon, String title, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColor.primary,
              size: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColor.textTitle,
                  fontSize: 20,
                ),
              ),
            ),
            const Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
