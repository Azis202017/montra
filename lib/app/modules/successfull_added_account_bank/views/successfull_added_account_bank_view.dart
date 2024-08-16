import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/theme/font.dart';
import '../controllers/successfull_added_account_bank_controller.dart';

class SuccessfullAddedAccountBankView
    extends GetView<SuccessfullAddedAccountBankController> {
  const SuccessfullAddedAccountBankView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuccessfullAddedAccountBankController>(
      initState: (_) {
        Timer.periodic(const Duration(seconds: 3), (timer) {
          Get.offAllNamed(Routes.WALLET_ACCOUNT);
          timer.cancel();
        } );
      },
      builder: (_) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/success.svg',
                  width: 96,
                  height: 96,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'You are set!',
                  style: title2,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
