import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/controllers/login_controller.dart';
import 'package:nextbasis_hris/services/auth_service.dart';
import 'package:nextbasis_hris/widgets/backgrounds/build_background_image.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(); // Instance of AuthService

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
                  loginInput(
                      context, controller, authService), // Pass AuthService
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginInput(BuildContext context, LoginController controller,
      AuthService authService) {
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
          ),
          const SizedBox(height: 10),
          // Google Sign-In Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            icon: Image.asset(
              'assets/google_logo.png',
              height: 20,
              width: 20,
            ),
            label: const Text('Sign in with Google'),
            onPressed: () async {
              User? user = await authService.signInWithGoogle();
              if (user != null) {
                print('Logged in as: ${user.displayName}');
                // Handle successful login
              }
            },
          ),
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
