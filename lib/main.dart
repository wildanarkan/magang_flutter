import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';
import 'package:magang_flutter/pages/login_page.dart';

void main(){
   Get.put(NavigatorPageControllers());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        dividerTheme: DividerThemeData(
          color: AppColor.line
        ),
        scaffoldBackgroundColor: AppColor.scaffold,
      ),
      home: const LoginPage(),
    );
  }
}