
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/font.dart';

class CustomTwoText extends StatelessWidget {
  final Color? color1;
  final Color? color2;

  final String? text1;
  final String? text2;
  final void Function()? onPressed;
  final TextDecoration? decoration;

  const CustomTwoText(
      {super.key,
      this.onPressed,
      this.text1,
      this.text2,
      this.color1 = dark100,
      this.color2 = violet100,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Center(
        child: RichText(
          text: TextSpan(
            text: text1,
            style: regular1.copyWith(
              color: color1,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: text2,
                style: regular1.copyWith(
                  color: color2,
                  fontWeight: FontWeight.w500,
                  decoration: decoration,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
