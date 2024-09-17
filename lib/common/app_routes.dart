abstract class AppRoutes {
  static const login = '/login';
  static const navigator = '/navigator';

  // Business Trip
  static const tripAdd = '/trip/add';
  static const tripDetail = '/trip/detail';

  // Planning 
  static const planning = '/trip/detail/planning';
  static const planningEdit = '/trip/detail/planning/edit';
  static const planningComparison = '/trip/detail/planning_comparison';

  // Leave
  static const leaveList = '/leave/list';
  static const leaveDetail = '/leave/list/detail';
  static const leaveAdd = '/leave/add';
  static const leavePersonal = '/leave/personal';

  // Profile
  static const profileDetail = '/profile/detail';
  static const profileEdit = '/profile/detail/edit';
  static const profileChangePassword = '/profile/detail/change_password';

  // Payroll
  static const payroll = '/payroll';
  static const payrollDetail = '/payroll/detail';

  // Contract
  static const contract = '/contract';
}