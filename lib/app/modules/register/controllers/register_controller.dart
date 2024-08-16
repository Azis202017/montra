import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/app/data/model/input/auth/register_input.dart';
import 'package:montra/app/helpers/alert_error.dart';
import 'package:montra/app/helpers/alert_success.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController nameTextEditingControler = TextEditingController();
  TextEditingController emailTextEditingControler = TextEditingController();
  TextEditingController passwordTextEditingControler = TextEditingController();
  TextEditingController passwordConfirmationEditingControler =
      TextEditingController();

  String name = "";
  String email = "";
  String password = "";
  String passwordConfirmation = "";
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordConfirmationFocusNode = FocusNode();
  bool isShowPassword = false;
  bool isShowPasswordConfirmation = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    update();
  }

  void changePasswordConfirmationVisibility() {
    isShowPasswordConfirmation = !isShowPasswordConfirmation;
    update();
  }

  bool isValid() {
    bool valid = formKey.currentState?.validate() ?? false;
    update();
    return valid;
  }

  void onChangeName(String? value) {
    name = value!;
    update();
  }

  void onChangeEmail(String? value) {
    email = value!;

    update();
  }

  void onChangePassword(String? value) {
    password = value!;

    update();
  }

  void onChangePasswordConfirmation(String? value) {
    passwordConfirmation = value!;

    update();
  }

  void onEditingSubmittedEmail() {
    FocusScope.of(Get.context!).requestFocus(emailFocusNode);
  }

  void onEditingSubmittedPassword() {
    FocusScope.of(Get.context!).requestFocus(passwordFocusNode);
  }

  void onEditingSubmittedPasswordConfirmation() {
    FocusScope.of(Get.context!).requestFocus(passwordConfirmationFocusNode);
  }

  void register() async {
    if (!formKey.currentState!.validate()) return; // Ensure form validation
    isLoading = true;
    RegisterInput registerInput = RegisterInput(
      email: emailTextEditingControler.text,
      password: passwordTextEditingControler.text,
      name: nameTextEditingControler.text,
      passwordConfirmation: passwordConfirmationEditingControler.text,
    );
    AuthService authService = AuthService();
    bool isRegistered =
        await authService.register(inputRegister: registerInput);
    if (isRegistered) {
      isLoading = false;

      alertSuccess(title: "Successfull", subtitle: "Yeayy youre acount is register now!");
      Get.offAllNamed(Routes.LOGIN);
    } else {
      isLoading = false;
      alertError(title: "Registration failed!", subtitle: authService.message);
    }
    update();
  }
}
