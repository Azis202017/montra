import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:montra/app/modules/splash/views/splash_view.dart';
import 'package:montra/app/shared/theme/colors.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/theme/font.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              _buildAccountProfile(),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildListTileSettings(
                      onTap: () => Get.toNamed(Routes.WALLET_ACCOUNT),
                      title: "Account",
                      image: "assets/images/account_settings.svg",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildListTileSettings(
                        onTap: controller.logout,
                        color: const Color(0xFFFFE2E4),
                        title: "Logout",
                        image: "assets/images/logout.svg"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildListTileSettings({
    void Function()? onTap,
    required String image,
    required String title,
    Color? color = violet20,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          // contentPadding: EdgeInsets.zero,
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
        ),
        const Divider()
      ],
    );
  }

  Row _buildAccountProfile() {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            border: Border.all(color: violet100, width: 2),
          ),
          child: const CustomImageAsset(image: 'onboarding1'),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Username", style: regular3.copyWith(color: light20)),
              Text("${controller.user?.name}",
                  style: title2.copyWith(color: dark75)),
            ],
          ),
        )
      ],
    );
  }

}
