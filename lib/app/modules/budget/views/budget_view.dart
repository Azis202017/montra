import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/budget_controller.dart';

class BudgetView extends GetView<BudgetController> {
  const BudgetView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
        centerTitle: true,
      ),
      body:  Center(
        child: Lottie.asset('assets/images/coming_soon_lottie.json'),
      ),
    );
  }
}
