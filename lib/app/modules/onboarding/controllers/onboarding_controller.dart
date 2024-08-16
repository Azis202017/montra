import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0;
  final PageController pageController = PageController();

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: "Gain total control of your money",
      description: "Become your own money manager and make every cent count",
      imagePath: "assets/images/onboarding1.png",
    ),
    OnboardingPageModel(
      title: "Know where your money goes",
      description: "Track your transaction easily, with categories and financial report",
      imagePath: "assets/images/onboarding2.png",
    ),
    OnboardingPageModel(
      title: "Planning ahead",
      description: "Setup your budget for each category so you in control",
      imagePath: "assets/images/onboarding3.png",
    ),
  ];

  void onPageChanged(int index) {
    currentPage = index;
    update();
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
