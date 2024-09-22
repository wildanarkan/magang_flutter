import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_pages.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/controllers/login_controller.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put(UserRepository());
  Get.put<LoginController>(LoginController(), permanent: true);
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
      getPages: AppPages.pages
    );
  }
}
