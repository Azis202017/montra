import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/model/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/colors.dart';
import '../../../shared/theme/font.dart';

class SettingsController extends GetxController {
  GetStorage storage = GetStorage();
  User? user;
  @override
  onInit() {
    getUser();
    super.onInit();
  }

  void getUser() {
    storage.read('user');
    if (storage.read('user') != null) {
      user = User.fromJson(storage.read('user'));
    }
  }

  void logout() {
    Get.bottomSheet(Container(
      height: 217,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Logout?",
            style: title3,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Are you sure do you wanna logout?",
            style: regular2.copyWith(
              color: light20,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffEEE5FF),
                      foregroundColor: violet100
                    ),
                    onPressed: () {
                      storage.remove('user');
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: const Text(
                      "Yes",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "NO",
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
