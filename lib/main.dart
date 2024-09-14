import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magang_flutter/bindings/change_password_binding.dart';
import 'package:magang_flutter/bindings/contract_binding.dart';
import 'package:magang_flutter/bindings/navigator_binding.dart';
import 'package:magang_flutter/bindings/payroll_history_binding.dart';
import 'package:magang_flutter/bindings/profile_edit_binding.dart';
import 'package:magang_flutter/bindings/trip_add_binding.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/common/app_routes.dart';
import 'package:magang_flutter/controllers/login_page_controller.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';
import 'package:magang_flutter/data/repo/user_repository.dart';
import 'package:magang_flutter/pages/business%20trip/add_businiess_trip_page.dart';
import 'package:magang_flutter/pages/business%20trip/business_trip_detail_page.dart';
import 'package:magang_flutter/pages/contract/contract_history_page.dart';
import 'package:magang_flutter/pages/leave/employee_leave_history_page.dart';
import 'package:magang_flutter/pages/login_page.dart';
import 'package:magang_flutter/pages/navigator_page.dart';
import 'package:magang_flutter/pages/payroll/payroll_detail_page.dart';
import 'package:magang_flutter/pages/payroll/payroll_history_page.dart';
import 'package:magang_flutter/pages/profile/change_password_page.dart';
import 'package:magang_flutter/pages/profile/edit_profile_page.dart';
import 'package:magang_flutter/pages/profile/profile_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(UserRepository());
  Get.put<LoginPageController>(LoginPageController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final isLoggedIn = storage.read('isLoggedIn') ?? false;

    return GetMaterialApp(
      theme: ThemeData(
        dividerTheme: DividerThemeData(color: AppColor.line),
        scaffoldBackgroundColor: AppColor.scaffold,
      ),
      initialRoute: isLoggedIn ? AppRoutes.navigator : AppRoutes.login,
      getPages: [
        GetPage(
          name: AppRoutes.login,
          page: () => const LoginPage(),
        ),
        GetPage(
          name: AppRoutes.navigator,
          page: () => const NavigatorPage(),
          binding: NavigatorBinding(),
        ),

        // Business Trip
        GetPage(
          name: AppRoutes.tripAdd,
          page: () => const AddBusiniessTripPage(),
          binding: TripAddBinding(),
        ),
        GetPage(
          name: AppRoutes.tripDetail,
          page: () => BusinessTripDetailPage(
            trip: Get.arguments['trip'] as BusinessTripModel,
            status: Get.arguments['status'] as String?,
          ),
        ),

        // Leave
        GetPage(
          name: AppRoutes.leaveList,
          page: () => EmployeeLeaveHistoryPage(),
        ),
        GetPage(
          name: AppRoutes.leaveListPending,
          page: () => EmployeeLeaveHistoryPage(
            statusFilter: 'Pending',
          ),
        ),

        // Profile
        GetPage(
          name: AppRoutes.profileDetail,
          page: () => const ProfileDetailPage(),
        ),
        GetPage(
          name: AppRoutes.profileChangePassword,
          // ignore: prefer_const_constructors
          page: () => ChangePasswordPage(),
          binding: ChangePasswordBinding(),
        ),
        GetPage(
          name: AppRoutes.profileEdit,
          page: () => const EditProfilePage(),
          binding: ProfileEditBinding(),
        ),

        // Payroll
        GetPage(
          name: AppRoutes.payroll,
          page: () => const PayrollHistoryPage(),
          binding: PayrollHistoryBinding(),
        ),
        GetPage(
          name: AppRoutes.payrollDetail,
          page: () =>
              PayrollDetailPage(payrollId: Get.parameters['payrollId']!),
        ),

        // Contract
        GetPage(
          name: AppRoutes.contract,
          page: () => const ContractHistoryPage(),
          binding: ContractBinding(),
        ),
      ],
    );
  }
}
