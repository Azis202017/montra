import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:montra/app/helpers/auth_helpers_validation.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/theme/colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/custom_two_text.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return GetBuilder<LoginController>(builder: (_) {
      return Form(
        key: controller.formKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Login',
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  text: "Email",
                  hint: "john.doe@gmail.com",
                  controller: controller.emailController,
                  validator: AuthHelpers().emailValidation,
                  onChanged: controller.onChangedEmail,
                  onEditingComplete: controller.onEditingPasswordSubmitted,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  text: "Password",
                  isPassword: true,
                  obsecureText: controller.isObsecureText,
                  controller: controller.passwordController,
                  validator: AuthHelpers().passwordValidation,
                  onChanged: controller.onChangedPassword,
                  focusNode: controller.passwordFocusNode,
                  hint: "**************",
                  changeVisibilityPassword: controller.changeVisiblityPassword,
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.checkedIsAllFieldIsEmpty()
                        ? controller.submittedLogin
                        : null,
                    child: controller.isLoading
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : const Text("Login"),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                 CustomTwoText(
                  text1: "Don't have an account yet? ",
                  text2: "Sign Up",
                  color1: light20,
                  color2: violet100,
                  decoration: TextDecoration.underline,
                  onPressed : () => Get.toNamed(Routes.REGISTER)
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

