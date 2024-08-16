import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/app/data/model/input/auth/login_input.dart';
import 'package:montra/app/data/services/auth_service.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Ubah inisialisasi ke false
  FocusNode passwordFocusNode = FocusNode();
  String email = "";
  String password = "";
  bool isObsecureText = true;

  void onEditingPasswordSubmitted() {
    FocusScope.of(Get.context!).requestFocus(passwordFocusNode);
  }
  void onChangedEmail(String? value) {
    email = value ?? "";
    update();
  }
  void onChangedPassword(String? value) {
    password = value ?? "";
    update();
  }
  bool checkedIsAllFieldIsEmpty() {
    if(email.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    return false;
  }
  void changeVisiblityPassword() {
    isObsecureText = !isObsecureText;
    update();
  }
  void submittedLogin() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      update(); // Update UI agar menampilkan loading

      AuthService authService = AuthService();
      bool isLoginSuccess = await authService.login(
        inputLogin: LoginInput(
            email: emailController.text, password: passwordController.text),
      );

      isLoading = false;
      update(); // Update UI setelah login selesai

      if (isLoginSuccess) {
        Get.snackbar('Login successful!', 'Login berhasil dilakukan');
        Get.offAllNamed(Routes.OTP);
      } else {
        Get.snackbar('Invalid email or password.', authService.message);
      }
    } 
  }
}
