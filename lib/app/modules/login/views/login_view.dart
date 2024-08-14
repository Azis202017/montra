import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:montra/app/helpers/auth_helpers_validation.dart';

import '../../../theme/font.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
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
                  controller: controller.emailController,
                  validator: AuthHelpers().emailValidation,
                  onEditingComplete: controller.onEditingPasswordSubmitted,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  text: "Password",
                  controller: controller.passwordController,
                  validator: AuthHelpers().passwordValidation,
                  focusNode: controller.passwordFocusNode,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.submittedLogin,
                    child: controller.isLoading
                        ? const CircularProgressIndicator(backgroundColor: Colors.white,)
                        : const Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.text = "",
    this.hint,
    this.focusNode,
    this.validator,
    this.onEditingComplete,
  });
  final TextEditingController controller;
  final String text;
  final String? hint;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: text.isNotEmpty,
          child: Text(text, style: title3),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.always,
          autocorrect: false,
          focusNode: focusNode,
          validator: validator,
          decoration: InputDecoration(hintText: hint ?? ""),
          onEditingComplete: onEditingComplete,
          
        ),
      ],
    );
  }
}
