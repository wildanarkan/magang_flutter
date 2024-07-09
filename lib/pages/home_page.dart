import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_card_info.dart';
import 'package:magang_flutter/widgets/build_expansion_tile.dart';
import 'package:magang_flutter/widgets/build_link.dart';

import '../controllers/navigator_page_controllers.dart';

class HomePage extends GetView<NavigatorPageControllers> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 25),
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              buildCardProfile(context),
              const SizedBox(
                height: 15,
              ),
              buildCurrentBusiness(context),
              const SizedBox(
                height: 15,
              ),
              buildSaveCollapse(context),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // BUILD WIDGET
  Container buildCurrentBusiness(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: VExpansionTile(
        childrenPadding: const EdgeInsets.all(0),
        tilePadding: EdgeInsets.zero,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        initiallyExpanded: false,
        title: Text(
          'Current Business Trip',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.textBody,
          ),
        ),
        children: const [
          BuildCardInfo(
            city: 'Surabaya',
            company: 'PT. Maju Jaya',
            appStatus: 'onProgress',
            useContainer: false,
          ),
        ],
      ),
    );
  }

  Widget buildSaveCollapse(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: VExpansionTile(
        childrenPadding: const EdgeInsets.all(0),
        tilePadding: EdgeInsets.zero,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        initiallyExpanded: false,
        title: Text(
          'Save Business Trip',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.textBody,
          ),
        ),
        children: [
          BuildLink(
            title: 'View All',
            context: context,
            onTap: () {
              controller.changePage(1);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const BuildCardInfo(
            city: 'Surabaya',
            company: 'PT. Maju Jaya',
            appStatus: 'onProgress',
          ),
          const SizedBox(
            height: 15,
          ),
          const BuildCardInfo(
            city: 'Bandung',
            company: 'PT. Sidomuncul',
            appStatus: 'complete',
          ),
        ],
      ),
    );
  }

  Widget buildCardProfile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/background.png',
                    height: 36,
                    width: 36,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wildan Arkan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColor.textTitle,
                      ),
                    ),
                    Text(
                      'HRD',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.textBody,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    BuildLink(
                      title: 'Go To Profile',
                      context: context,
                      onTap: () {
                        controller.changePage(3);
                      },
                    ),
                    const Text(
                      ' ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(),
            ),
            Text(
              'Your Attendance Today',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColor.textBody,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_filled,
                        size: 36,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Time',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textBody,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            DateFormat.Hm().format(DateTime.now()).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColor.textTitle,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        size: 36,
                        color: Colors.red[300],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Time',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textBody,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            DateFormat.Hm().format(DateTime.now()).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColor.textTitle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
