import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/login_controller.dart';
import 'package:nextbasis_hris/widgets/backgrounds/build_background_image.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const BuildBackgroundImage(
              imageProvider: AssetImage('assets/background.png'),
              imageAlignment: Alignment(0.16, 0),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  buildHeader(),
                  const Spacer(),
                  loginInput(context, controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginInput(BuildContext context, LoginController controller) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: controller.edtUsername.value,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    prefixIcon: Icon(
                      Icons.person,
                      size: 25,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const Divider(),
                TextField(
                  controller: controller.edtPassword.value,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 25,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () {
              return BuildButton(
                context: context,
                title: controller.isLoading.value ? 'Loading...' : 'Login',
                onPressed: () {
                  log('Login....');
                  controller.login();
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Positioned(
            top: -20,
            left: 30,
            right: 30,
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcATop,
              ),
              child: Image.asset(
                'assets/logo.png',
                height: 350,
                width: 350,
              ),
            ),
          ),
          const Positioned(
            top: 240,
            left: 30,
            right: 30,
            bottom: 0,
            child: Text(
              'The Distribution must Transforms',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
