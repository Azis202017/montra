import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:montra/app/routes/app_pages.dart';
import 'package:montra/app/shared/theme/colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(initState: (_) {
      Timer.periodic(const Duration(seconds: 2), (timer) {
        Get.offAllNamed(Routes.ONBOARDING);
        timer.cancel();
      });
    }, builder: (context) {
      return const Scaffold(
        backgroundColor: violet100,
        body: Center(
          child: CustomImageAsset(
            image: 'logo',
            width:200
          ),
        ),
      );
    });
  }
}

class CustomImageAsset extends StatelessWidget {
  const CustomImageAsset({
    super.key,
    this.width,
    this.height,
    this.boxFit,
    required this.image,
  });
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/$image.png',
        width: width, height: height, fit: boxFit);
  }
}
