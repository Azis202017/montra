import 'package:get/get.dart';

import '../../../data/model/wallet_model.dart';
import '../../../data/services/wallet_service.dart';

class WalletAccountController extends GetxController {
  List<Wallet> listWallet = [];
  bool isLoading = true;

  void wallet() async {
    listWallet = await WalletService().wallet();
    isLoading = false;
    update();
  }

  void deleteWallet(int id) async {
    await WalletService().deleteWallet(id: id);
    wallet();
  }

  @override
  onInit() {
    wallet();
    super.onInit();
  }
}
