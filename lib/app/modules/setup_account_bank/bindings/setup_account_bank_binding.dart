import 'package:get/get.dart';

import '../controllers/setup_account_bank_controller.dart';

class SetupAccountBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetupAccountBankController>(
      () => SetupAccountBankController(),
    );
  }
}
