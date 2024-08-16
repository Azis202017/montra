import 'package:flutter/material.dart';
import 'package:montra/app/shared/theme/colors.dart';
import 'package:montra/app/shared/theme/font.dart';

ThemeData themeData = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: light100,
    foregroundColor: dark50,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: violet100,
      textStyle: title3.copyWith(
        color: light80,
        
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),
  scaffoldBackgroundColor: light100,
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    outlineBorder: BorderSide(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: light60,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: dark25,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: red100,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: red100,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
  ),
  // scaffoldBackgroundColor: accentColor,
  useMaterial3: false,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      side: const BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: violet100,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: violet100,
  ),
);
