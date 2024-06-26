import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/pages/login_page.dart';

void main(){
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
        scaffoldBackgroundColor: AppColor.iconBrown,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}