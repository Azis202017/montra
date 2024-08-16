import 'package:flutter/material.dart';

import '../theme/font.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.text = "",
      this.hint,
      this.focusNode,
      this.validator,
      this.onEditingComplete,
      this.onChanged,
      this.obsecureText = false,
      this.isPassword = false,
      this.changeVisibilityPassword,
      this.readOnly = false,
      this.inputKeyboardType,
      this.suffixIcon});
  final TextEditingController controller;
  final String text;
  final String? hint;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final bool readOnly;

  final TextInputType? inputKeyboardType;
  final void Function()? onEditingComplete;
  final void Function()? changeVisibilityPassword;
  final Widget? suffixIcon;
  final bool obsecureText;
  final bool isPassword;
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
          keyboardType: inputKeyboardType,
          controller: controller,
          readOnly: readOnly,
          autovalidateMode: AutovalidateMode.always,
          autocorrect: false,
          obscureText: obsecureText,
          focusNode: focusNode,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint ?? "",
            suffixIcon: isPassword
                ? Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                    ),
                    child: InkWell(
                      onTap: changeVisibilityPassword,
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  )
                : suffixIcon,
            contentPadding: const EdgeInsets.all(
              24,
            ),
          ),
          onEditingComplete: onEditingComplete,
        ),
      ],
    );
  }
}
