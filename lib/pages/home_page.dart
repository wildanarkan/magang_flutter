import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/business_trip_page.dart';
import 'package:magang_flutter/pages/profile_page.dart';
import 'package:magang_flutter/widgets/build_card_info.dart';
import 'package:magang_flutter/widgets/build_expansion_tile.dart';
import 'package:magang_flutter/widgets/build_link.dart';
import 'package:magang_flutter/widgets/build_shape.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: BuildShape(),
            child: Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                color: AppColor.primary,
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
    return  Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: VExpansionTile(
        childrenPadding: const EdgeInsets.all(0),
        tilePadding: EdgeInsets.zero,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        initiallyExpanded: true,
        title: Text(
          'Save Business Trip',
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
        initiallyExpanded: true,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BusinessTripPage(),
                ),
              );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
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
