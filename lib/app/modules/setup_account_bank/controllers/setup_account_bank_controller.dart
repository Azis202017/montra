import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/app/data/model/input/wallet/wallet_input.dart';
import 'package:montra/app/helpers/alert_error.dart';

import '../../../data/model/wallet_model.dart';
import '../../../data/services/wallet_service.dart';
import '../../../routes/app_pages.dart';
import '../../wallet_account/controllers/wallet_account_controller.dart';

class SetupAccountBankController extends GetxController {
  TextEditingController nameWallet = TextEditingController();
  String name = "";
  int? id;
  Wallet? wallet;
  bool isLoading = true;
  void onChange(String? value) {
    name = value ?? "";
    update();
  }

  @override
  onInit() {
    fetchDetailId();
    if (id != null) {}
    isLoading = false;
    super.onInit();
  }

  void fetchDetailId() async {
    if (id == null) {
      id = Get.arguments['id'];
      wallet = await WalletService().fetchDetailWallet(id: id);
      if (wallet != null) {
        nameWallet.text = wallet?.name ?? "";
      }
    }
    isLoading = false;
    update();
  }

  void submitAccountBank() {
    if (id == null) {
      createAccountName();
    } else {
      updateAccountName();
    }
  }

  void createAccountName() async {
    WalletInput walletInput = WalletInput(name: nameWallet.text);
    bool isAcountSuccess = await WalletService().createWallet(
      inputWallet: walletInput,
    );
    if (isAcountSuccess) {
      Get.offAllNamed(Routes.SUCCESSFULL_ADDED_ACCOUNT_BANK);
      var controller = Get.put(WalletAccountController());
      controller.wallet();
      controller.update();
    } else {
      alertError(
          title: "Opss something wrong", subtitle: "Try again please...");
    }
  }

  void updateAccountName() async {
    WalletInput walletInput = WalletInput(name: nameWallet.text);

    bool isAcountSuccess =
        await WalletService().editWallet(inputWallet: walletInput, id: id!);
    if (isAcountSuccess) {
      Get.offAllNamed(Routes.SUCCESSFULL_ADDED_ACCOUNT_BANK);
      var controller = Get.put(WalletAccountController());
      controller.wallet();
      controller.update();
    } else {
      alertError(
          title: "Opss something wrong", subtitle: "Try again please...");
    }
  }
}
