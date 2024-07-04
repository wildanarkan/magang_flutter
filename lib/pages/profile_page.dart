import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/contract_history_page.dart';
import 'package:magang_flutter/pages/leave_history_page.dart';
import 'package:magang_flutter/pages/payroll_history_page.dart';
import 'package:magang_flutter/pages/profile_detail_page.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_rowicon.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({ super.key });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            children:  [
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
              Positioned(
                top: 240,
                left: 30,
                right: 30,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Container(
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(top: 75),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Kevin Anggara',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                'HRD',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textBody
                                ),
                              )
                            ],
                          ),
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
                                builder: (context) => const ProfileDetailPage(),
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
                                builder: (context) => const LeaveHistoryPage(),
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
                                builder: (context) => const PayrollHistoryPage(),
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
                                builder: (context) => const ContractHistoryPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
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
         Align(
           alignment: Alignment.bottomCenter,
           child: Padding(
              padding: const EdgeInsets.fromLTRB(35,0, 35, 140),
              child: BuildButton(
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
            ),
         ),
        ],
      ),
    );
  }
}