import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:montra/app/shared/theme/colors.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../shared/theme/font.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(builder: (_) {
      return Scaffold(
        backgroundColor: violet100,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.title,
              style: title1.copyWith(
                color: light100,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: OtpPinField(
                textInputAction: TextInputAction.done,
                key: controller.otpPinFieldController,
                upperChild: Text(
                  controller.title,
                  style: title2.copyWith(
                    color: light100,
                  ),
                ),
                otpPinFieldDecoration:
                    OtpPinFieldDecoration.roundedPinBoxDecoration,
                otpPinInputCustom: "",
                otpPinFieldStyle: const OtpPinFieldStyle(
                  activeFieldBackgroundColor: light100,
                  activeFieldBorderColor: light100,
                  filledFieldBackgroundColor: light100,
                  filledFieldBorderColor: light100,
                  defaultFieldBorderColor: light100,
                ),
                onSubmit: controller.onSubmit,
                onChange: controller.onChange,
              ),
            ),
          ],
        ),
      );
    });
  }
}
