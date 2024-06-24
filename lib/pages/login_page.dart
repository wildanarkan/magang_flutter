import 'package:flutter/material.dart';
import 'package:magang_flutter/widgets/background_image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  login(String email, String password, BuildContext context) {
    // Implement your login logic here
  }

  @override
  void dispose() {
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      fit: StackFit.expand,
      children: [
        const BackgroundImage(
          imageProvider: AssetImage('assets/background.png'),
          imageAlignment: Alignment(0.16, 0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(),
            const Spacer(),
            loginInput(),
          ],
        ),
      ],
    ),
  );
}


  Widget loginInput() {
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
                  controller: edtEmail,
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
                  controller: edtPassword,
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
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
              child: const Text(
                'Login',
              ),
            ),
          )
        ],
      ),
    );
  }

  AspectRatio buildHeader() {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Positioned(
            left: 30,
            right: 30,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ColorFiltered(
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
                const SizedBox(width: 20),
              ],
            ),
          ),
          const Positioned(
            top: 300,
            left: 30,
            right: 30,
            bottom: 0,
            child: Text(
              'The Distribution must Transform',
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
