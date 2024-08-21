import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/personal_leave_history_page_controller.dart';
import 'package:magang_flutter/pages/leave_request_detail_page.dart';
import 'package:magang_flutter/widgets/build_card_info.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';

class PersonalLeaveHistoryPage extends StatelessWidget {
  const PersonalLeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonalLeaveHistoryPageController controller = Get.put(PersonalLeaveHistoryPageController());

    return Scaffold(
      appBar: BuildTestAppbar(
        title: 'Leave History',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_rounded),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator()); // Menampilkan loading saat data sedang diambil
          }

          if (controller.leaves.isEmpty) {
            return const Center(child: Text("No leave history available")); // Menampilkan pesan jika data kosong
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 120, top: 20),
            itemCount: controller.leaves.length,
            itemBuilder: (context, index) {
              final leave = controller.leaves[index];

              return BuildCardInfo(
                title: leave.leaveCategory ?? '', 
                appStatus: leave.status ?? '', 
                startDate: leave.startDate ?? '',
                endDate: leave.endDate ?? '',
                icon: Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: AppColor.textBody,
                ),
                onTap: () {
                  Get.to(() => const LeaveRequestDetailPage()); 
                },
              );
            },
          );
        }),
      ),
    );
  }
}
