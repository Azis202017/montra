import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:montra/app/shared/theme/font.dart';
import '../../../data/model/wallet_model.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/colors.dart';
import '../controllers/wallet_account_controller.dart';

class WalletAccountView extends GetView<WalletAccountController> {
  const WalletAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(WalletAccountController());
    return GetBuilder<WalletAccountController>(builder: (_) {
      return controller.isLoading
          ? const Material(child: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () => Get.offAllNamed(Routes.BOTTOM),
                    icon: const Icon(Icons.arrow_back)),
                title: const Text('Account'),
                centerTitle: true,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTotalWallet(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.listWallet.length,
                      itemBuilder: (_, index) {
                        Wallet data = controller.listWallet[index];
                        return Dismissible(
                          key: Key(
                              data.id.toString()), // Unique key for each item
                          direction: DismissDirection
                              .endToStart, // Swipe from right to left
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            controller.deleteWallet(
                                data.id!); // Call the delete method
                          },
                          child: _buildListTileSettings(
                            title: "${data.name}",
                            image: "assets/images/account_settings.svg",
                            onPressed: () => Get.toNamed(
                                Routes.SETUP_ACCOUNT_BANK,
                                arguments: {
                                  "id": data.id,
                                }),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                margin: const EdgeInsets.all(16),
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.SETUP_ACCOUNT_BANK,);
                  },
                  child: const Text(
                    "+Add account bank",
                  ),
                ),
              ),
            );
    });
  }

  Container _buildTotalWallet() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/BG.png'),
        ),
      ),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Total Wallet", style: regular3),
          Text(
            "${controller.listWallet.length}",
            style: titleX.copyWith(
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildListTileSettings({
    void Function()? onTap,
    required String image,
    required String title,
    void Function()? onPressed,
    Color? color = violet20,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            width: 52,
            height: 52,
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              image,
            ),
          ),
          title: Text(title, style: regular1),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onPressed,
          ),
        ),
        const Divider()
      ],
    );
  }
}
