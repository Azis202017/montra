import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/theme/colors.dart';
import '../../../shared/theme/font.dart';
import '../controllers/setup_bank_controller.dart';

class SetupBankView extends GetView<SetupBankController> {
  const SetupBankView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 53,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Let's setup your account!", style: title1),
              const SizedBox(
                height: 37,
              ),
              Text(
                "Account can be your bank, credit card or your wallet.",
                style: regular3,
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: SizedBox(
            width: double.infinity,
            height:53,
            child: ElevatedButton(
              onPressed: controller.goNewAccountPage,
              child: Text(
                "Let's go",
                style: title3.copyWith(
                  color: light80,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
