import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class SetupBankController extends GetxController {
void goNewAccountPage() {
  Get.toNamed(Routes.SETUP_ACCOUNT_BANK, arguments : {
    "id": null,
  });
  GetStorage().write('setup_account', 1);
}

}
