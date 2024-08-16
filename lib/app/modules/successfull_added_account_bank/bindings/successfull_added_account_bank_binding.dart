import 'package:get/get.dart';

import '../controllers/successfull_added_account_bank_controller.dart';

class SuccessfullAddedAccountBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessfullAddedAccountBankController>(
      () => SuccessfullAddedAccountBankController(),
    );
  }
}
