import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../helpers/alert_error.dart';
import '../../../routes/app_pages.dart';

class OtpController extends GetxController {
  final otpPinFieldController = GlobalKey<OtpPinFieldState>();
  String title = "Let's go put the pin";
  // onSubmit: (String text) {
  //         if (text == "8888") {

  //           Get.toNamed(Routes.HOME);
  //         } else {
  //           alertError(title: "Opss Something Wrong", subtitle: "OTP is incorrect");
  //         }
  //       },
  //       onChange: (String text) {},
  void onSubmit(String text) {
    if (text == "8888") {

      if (GetStorage().read('setup_account') == null) {
        Get.offAllNamed(Routes.SETUP_BANK);
      }else {
        Get.offAllNamed(Routes.BOTTOM);

      }
    } else {
      alertError(title: "Opss Something Wrong", subtitle: "OTP is incorrect");
    }
  }

  void onChange(String text) {
    if (text.isEmpty) {
      title = "Let's go put the pin";
    } else if (text.isNotEmpty && text.length <= 3) {
      title = "Go on input your pin";
    } else {
      title = "Ok. Re type your pin again";
    }
    update();
  }
}
