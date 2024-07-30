import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/login_page_controller.dart';
import 'package:magang_flutter/pages/login_page.dart';
import 'package:magang_flutter/pages/navigator_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.lazyPut(() => LoginPageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final isLoggedIn = box.read('isLoggedIn') ?? false;

    return GetMaterialApp(
      theme: ThemeData(
        dividerTheme: DividerThemeData(color: AppColor.line),
        scaffoldBackgroundColor: AppColor.scaffold,
      ),
      home: isLoggedIn ? const NavigatorPage() : const LoginPage(),
    );
  }
}
