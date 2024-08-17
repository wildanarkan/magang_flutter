import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang_flutter/controllers/login_page_controller.dart';
import 'package:magang_flutter/widgets/background_image.dart';
import 'package:magang_flutter/widgets/build_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginPageController controller = Get.find<LoginPageController>();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const BackgroundImage(
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

  Widget loginInput(BuildContext context, LoginPageController controller) {
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
                  controller: controller.edtEmail.value,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.email_rounded,
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
          BuildButton(
            context: context,
            title: 'Login',
            onPressed: () {
              controller.login();
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
