import 'package:get/get.dart';
import 'package:nextbasis_hris/bindings/change_password_binding.dart';
import 'package:nextbasis_hris/bindings/code_otp_binding.dart';
import 'package:nextbasis_hris/bindings/contract_binding.dart';
import 'package:nextbasis_hris/bindings/leave_add_binding.dart';
import 'package:nextbasis_hris/bindings/leave_history_binding.dart';
import 'package:nextbasis_hris/bindings/leave_history_detail_binding.dart';
import 'package:nextbasis_hris/bindings/leave_personal_binding.dart';
import 'package:nextbasis_hris/bindings/navigator_binding.dart';
import 'package:nextbasis_hris/bindings/payroll_history_binding.dart';
import 'package:nextbasis_hris/bindings/planning_binding.dart';
import 'package:nextbasis_hris/bindings/planning_comparison_binding.dart';
import 'package:nextbasis_hris/bindings/planning_edit_binding.dart';
import 'package:nextbasis_hris/bindings/profile_update_binding.dart';
import 'package:nextbasis_hris/bindings/trip_add_binding.dart';
import 'package:nextbasis_hris/bindings/trip_detail_binding.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/data/models/business_trip_model.dart';
import 'package:nextbasis_hris/pages/business%20trip/trip_add_page.dart';
import 'package:nextbasis_hris/pages/business%20trip/trip_detail_page.dart';
import 'package:nextbasis_hris/pages/contract/contract_history_page.dart';
import 'package:nextbasis_hris/pages/leave/leave_add_page.dart';
import 'package:nextbasis_hris/pages/leave/leave_history_detail_page.dart';
import 'package:nextbasis_hris/pages/leave/leave_history_page.dart';
import 'package:nextbasis_hris/pages/leave/leave_personal_page.dart';
import 'package:nextbasis_hris/pages/login/code_otp_page.dart';
import 'package:nextbasis_hris/pages/login/login_page.dart';
import 'package:nextbasis_hris/pages/navigator_page.dart';
import 'package:nextbasis_hris/pages/payroll/payroll_detail_page.dart';
import 'package:nextbasis_hris/pages/payroll/payroll_history_page.dart';
import 'package:nextbasis_hris/pages/planning/planning_comparison_page..dart';
import 'package:nextbasis_hris/pages/planning/planning_page.dart';
import 'package:nextbasis_hris/pages/planning/planning_update_page.dart';
import 'package:nextbasis_hris/pages/profile/change_password_page.dart';
import 'package:nextbasis_hris/pages/profile/profile_detail_page.dart';
import 'package:nextbasis_hris/pages/profile/profile_update_page.dart';

class AppPages {
  static final pages = [
    // Login
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const CodeOtpPage(),
      binding: CodeOtpBinding()
    ),
    GetPage(
      name: AppRoutes.navigator,
      page: () => const NavigatorPage(),
      binding: NavigatorBinding(),
    ),

    // Business Trip
    GetPage(
      name: AppRoutes.tripAdd,
      page: () => const TripAddPage(),
      binding: TripAddBinding(),
    ),
    GetPage(
      name: AppRoutes.tripDetail,
      page: () => TripDetailPage(
        trip: Get.arguments['trip'] as BusinessTripModel,
        status: Get.arguments['status'] as String?,
      ),
      binding: TripDetailBinding(),
    ),

    // Planning
    GetPage(
      name: AppRoutes.planning,
      page: () => const PlanningPage(),
      binding: PlanningBinding(),
    ),
    GetPage(
      name: AppRoutes.planningComparison,
      page: () => PlanningComparisonPage(
          idBusinessTrip: Get.arguments['idBusinessTrip']),
      binding: PlanningComparisonBinding(),
    ),
    GetPage(
      name: AppRoutes.planningEdit,
      page: () => PlanningUpdatePage(
        idBusinessTrip: Get.arguments['idBusinessTrip'],
        biayaType: Get.arguments['biayaType'],
        idItem: Get.arguments['idItem'],
        isEditMode: Get.arguments['isEditMode'],
      ),
      binding: PlanningEditBinding(),
    ),

    // Leave
    GetPage(
      name: AppRoutes.leaveList,
      page: () => const LeaveHistoryPage(),
      binding: LeaveHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.leaveDetail,
      page: () => LeaveHistoryDetailPage(
        leave: Get.arguments['leave'],
      ),
      binding: LeaveHistoryDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.leaveAdd,
      page: () => const LeaveAddPage(),
      binding: LeaveAddBinding(),
    ),
    GetPage(
      name: AppRoutes.leavePersonal,
      page: () => const LeavePersonalPage(),
      binding: LeavePersonalBinding(),
    ),

    // Profile
    GetPage(
      name: AppRoutes.profileDetail,
      page: () => const ProfileDetailPage(),
    ),
    GetPage(
      name: AppRoutes.profileChangePassword,
      page: () => const ChangePasswordPage(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.profileEdit,
      page: () => const ProfileUpdatePage(),
      binding: ProfileUpdateBinding(),
    ),

    // Payroll
    GetPage(
      name: AppRoutes.payroll,
      page: () => const PayrollHistoryPage(),
      binding: PayrollHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.payrollDetail,
      page: () => PayrollDetailPage(payrollId: Get.parameters['payrollId']!),
    ),

    // Contract
    GetPage(
      name: AppRoutes.contract,
      page: () => const ContractHistoryPage(),
      binding: ContractBinding(),
    ),
  ];
}
