import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/app/shared/theme/colors.dart';
import '../../../helpers/wallet_helpers_validation.dart';
import '../../../shared/theme/font.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../controllers/setup_account_bank_controller.dart';

class SetupAccountBankView extends GetView<SetupAccountBankController> {
  const SetupAccountBankView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetupAccountBankController>(
      builder: (context) {
        return  controller.isLoading ? const Material(child: Center(child: CircularProgressIndicator())) : SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: violet100,
            appBar: AppBar(
              foregroundColor: Colors.white,
              title: Text(
                 controller.id == null ?  'Add new account' : 'Update account',
                style: title3.copyWith(color: light100),
              ),
              backgroundColor: violet100,
              centerTitle: true,
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  reverse: true, // Keeps the view above the keyboard
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              "assets/images/onboarding1.png",
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 15,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextField(
                                  controller: controller.nameWallet,
                                  hint: "Name account",
                                  onChanged: controller.onChange,
                                  validator: WalletHelpers().walletValidationEmpty,
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  height: 58,
                                  child: ElevatedButton(
                                    onPressed: controller.name.isEmpty ? null : controller.submitAccountBank,
                                    child: const Text("Save"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }
}
