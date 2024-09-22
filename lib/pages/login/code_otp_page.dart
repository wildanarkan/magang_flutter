import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/controllers/code_otp_controller.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';

class CodeOtpPage extends GetView<CodeOtpController> {
  const CodeOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppComponent.marginPage),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(
                  Icons.verified_user_rounded,
                  color: AppColor.primary,
                  size: 120,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Verification Code',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
             Column(
              children: [
                const Text(
                  'We have sent the code verification to :',
                ),
                Text(
                  controller.obscureEmail('cillmystic@gmail.com'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Enter Code OTP'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildOtpField(controller.controller1, context),
                          const SizedBox(width: 10),
                          _buildOtpField(controller.controller2, context),
                          const SizedBox(width: 10),
                          _buildOtpField(controller.controller3, context),
                          const SizedBox(width: 10),
                          _buildOtpField(controller.controller4, context),
                          const SizedBox(width: 10),
                          _buildOtpField(controller.controller5, context),
                          const SizedBox(width: 10),
                          _buildOtpField(controller.controller6, context),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.resetField(),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BuildButton(
              title: 'VERIFY',
              onPressed: () {
                controller.printField();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Text("Didn't receive the Code OTP? "),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'RESEND',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(
      TextEditingController controller, BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
      ),
    );
  }
}
