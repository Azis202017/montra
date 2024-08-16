import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helpers/auth_helpers_validation.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/custom_two_text.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (context) {
      return Form(
        key: controller.formKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Sign Up',
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
                  text: "Name",
                  hint: "john.doe",
                  controller: controller.nameTextEditingControler,
                  validator: AuthHelpers().nameValidation,
                  onChanged: controller.onChangeName,
                  onEditingComplete: controller.onEditingSubmittedEmail,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  focusNode: controller.emailFocusNode,
                  text: "Email",
                  hint: "john.doe@gmail.com",
                  controller: controller.emailTextEditingControler,
                  validator: AuthHelpers().emailValidation,
                  onChanged: controller.onChangeEmail,
                  onEditingComplete: controller.onEditingSubmittedPassword,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  focusNode: controller.passwordFocusNode,
                  text: "Password",
                  isPassword: true,
                  obsecureText: controller.isShowPassword,
                  controller: controller.passwordTextEditingControler,
                  validator: AuthHelpers().passwordValidation,
                  onChanged: controller.onChangePassword,
                  onEditingComplete:
                      controller.onEditingSubmittedPasswordConfirmation,
                  hint: "**************",
                  changeVisibilityPassword: controller.changePasswordVisibility,
                ),
                CustomTextField(
                  focusNode: controller.passwordConfirmationFocusNode,
                  text: "Password Confirmation",
                  isPassword: true,
                  obsecureText: controller.isShowPasswordConfirmation,
                  controller: controller.passwordConfirmationEditingControler,
                  validator: (value) {
                    return AuthHelpers().confirmPasswordValidation(
                        controller.passwordTextEditingControler.text, value);
                  },
                  onChanged: controller.onChangePasswordConfirmation,
                  hint: "**************",
                  changeVisibilityPassword:
                      controller.changePasswordConfirmationVisibility,
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed:
                        controller.isValid() ? controller.register : null,
                    child: controller.isLoading
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : const Text("Sign Up"),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // _buildSignUp(),
                CustomTwoText(
                    text1: "Already have an account? ",
                    text2: "Login",
                    color1: light20,
                    color2: violet100,
                    decoration: TextDecoration.underline,
                    onPressed: () => Get.offAllNamed(Routes.LOGIN)),
              ],
            ),
          ),
        ),
      );
    });
  }
}
