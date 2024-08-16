import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:montra/app/modules/budget/controllers/budget_controller.dart';
import 'package:montra/app/modules/settings/controllers/settings_controller.dart';
import 'package:montra/app/shared/theme/colors.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/theme/font.dart';
import '../../home/controllers/home_controller.dart';
import '../../splash/views/splash_view.dart';
import '../../transaction/controllers/transaction_controller.dart';
import '../controllers/bottom_controller.dart';

class BottomView extends GetView<BottomController> {
  const BottomView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(SettingsController());
    Get.put(BudgetController());
    Get.put(BottomController());


    Get.put(TransactionController());

    return GetBuilder<BottomController>(
      builder: (_) {
        return Scaffold(
          extendBody: true,
          floatingActionButton: FloatingActionButton(
            backgroundColor: red100,
            onPressed: () {
              Get.toNamed(Routes.EXPENSE, arguments: {
                'id': null,
              });
            },
            child: const CustomImageAsset(
              image: 'wallet_expense',
              width:32, height:32,
            ),
          ),
          body: controller.pages.elementAt(controller.index),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: BottomNavigationBar(
                  onTap: (index) {
                    controller.index = index; 
                    controller.update();
                  },

                  currentIndex: controller.index,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    selectedLabelStyle: tiny2,
                    unselectedLabelStyle: tiny2.copyWith(
                      color: const Color(0xffC6C6C6),
                    ),
                    items: controller.items),
              ),
            ),
          ),
        );
      }
    );
  }
}
