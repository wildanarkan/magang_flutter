import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/personal_leave_history_page_controller.dart';
import 'package:magang_flutter/widgets/appbars/build_appbar.dart';
import 'package:magang_flutter/widgets/cards/build_card_info.dart';

class PersonalLeaveHistoryPage extends StatelessWidget {
  const PersonalLeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonalLeaveHistoryPageController controller =
        Get.put(PersonalLeaveHistoryPageController());

    return Scaffold(
      appBar: BuildAppbar(
        title: 'Leave History',
        actions: [
          IconButton(
            onPressed: () => _showFilterBottomSheet(context, controller),
            icon: const Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator()); // Menampilkan loading saat data sedang diambil
          }

          if (controller.filteredLeaves.isEmpty) {
            return Center(child: Text("No leave history ${controller.statusFilter.value}")); // Menampilkan pesan jika data kosong
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 120, top: 20),
            itemCount: controller.filteredLeaves.length,
            itemBuilder: (context, index) {
              final leave = controller.filteredLeaves[index];

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
                // onTap: () {
                //   controller.statusFilter.value = '';
                //   Get.to(() => LeaveHistoryDetailPage(leave: leave));
                // },
              );
            },
          );
        }),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, PersonalLeaveHistoryPageController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Pending'),
              onTap: () {
                controller.statusFilter.value = 'Pending';
                Get.back(closeOverlays: true);
              },
            ),
            ListTile(
              title: const Text('Approved'),
              onTap: () {
                controller.statusFilter.value = 'Approved';
                Get.back(closeOverlays: true);
              },
            ),
            ListTile(
              title: const Text('Declined'),
              onTap: () {
                controller.statusFilter.value = 'Declined';
                Get.back(closeOverlays: true);
              },
            ),
            ListTile(
              title: const Text('All'),
              onTap: () {
                controller.statusFilter.value = ''; // Reset filter
                Get.back(closeOverlays: true);
              },
            ),
          ],
        );
      },
    );
  }
}
