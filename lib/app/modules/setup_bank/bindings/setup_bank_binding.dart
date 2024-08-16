import 'package:get/get.dart';

import '../controllers/setup_bank_controller.dart';

class SetupBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetupBankController>(
      () => SetupBankController(),
    );
  }
}
