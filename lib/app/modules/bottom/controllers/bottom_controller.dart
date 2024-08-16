import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:montra/app/modules/settings/views/settings_view.dart';
import 'package:montra/app/modules/transaction/views/transaction_view.dart';

import '../../budget/views/budget_view.dart';
import '../../home/views/home_view.dart';

class BottomController extends GetxController {
  int index = 0;
  List<Widget> pages = [
    const HomeView(),
    const TransactionView(),
    const BudgetView(),
    const SettingsView(),
  ];
  List<BottomNavigationBarItem> items = [];

  void buildItems() {
    items = [
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          "assets/images/active_home.svg",
          width: 24,
          height: 24,
        ),
        icon: SvgPicture.asset(
          "assets/images/home.svg",
          width: 24,
          height: 24,
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
         activeIcon: SvgPicture.asset(
          "assets/images/active_transaction.svg",
          width: 24,
          height: 24,
        ),
        icon: SvgPicture.asset(
          "assets/images/transaction.svg",
          width: 24,
          height: 24,
        ),
        label: "Transaction",
      ),
      BottomNavigationBarItem(
         activeIcon: SvgPicture.asset(
          "assets/images/active_budget.svg",
          width: 24,
          height: 24,
        ),
        icon: SvgPicture.asset(
          "assets/images/budget.svg",
          width: 24,
          height: 24,
        ),
        label: "Bottom",
      ),
      BottomNavigationBarItem(
         activeIcon: SvgPicture.asset(
          "assets/images/active_user.svg",
          width: 24,
          height: 24,
        ),
        icon: SvgPicture.asset(
          "assets/images/user.svg",
          width: 24,
          height: 24,
        
        ),
        label: "Person",
      ),
    ];
  }

  @override
  onInit() {
    buildItems();
    super.onInit();
  }
}
