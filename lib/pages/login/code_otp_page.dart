import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_component.dart';
import 'package:nextbasis_hris/controllers/code_otp_controller.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeOtpPage extends GetView<CodeOtpController> {
  const CodeOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        bool shouldClose = await controller.exitDialog(context);
        if (shouldClose) {
          log('true');
          Get.offAllNamed('/login');
        } else {
          log('false');
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppComponent.marginPage),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Ensure content is centered
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
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
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              const Text(
                                  'We have sent the code verification to:'),
                              Text(
                                controller.obscureEmail(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Enter Code OTP'),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Form(
                                    child: PinCodeTextField(
                                      appContext: context,
                                      length: 6,
                                      controller: controller.otpController,
                                      keyboardType: TextInputType.number,
                                      textStyle: const TextStyle(
                                          fontSize: 20, height: 1.6),
                                      cursorColor: Colors.black,
                                      animationDuration: Duration.zero,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        inactiveColor: AppColor.textBody,
                                        activeColor: AppColor.primary,
                                        selectedColor: AppColor.primary,
                                        borderRadius: BorderRadius.circular(8),
                                        fieldHeight: 50,
                                        fieldWidth: 40,
                                        activeFillColor: Colors.white,
                                      ),
                                      onChanged: (value) {},
                                      onCompleted: (value) {
                                        controller.verifyOtp();
                                      },
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => controller.resetField(),
                                  child: Align(
                                    alignment: Alignment.topRight,
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
                          Obx(() {
                            return BuildButton(
                              title: controller.isLoading.value
                                  ? 'Loading...'
                                  : 'VERIFY',
                              onPressed: () {
                                controller.verifyOtp();
                              },
                            );
                          }),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Resend Code OTP in : "),
                                  Obx(
                                    () => Text(
                                      controller.getFormattedTime(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.sendOtp();
                                },
                                child: Text(
                                  'RESEND',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}