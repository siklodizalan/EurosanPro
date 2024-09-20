import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.black,
    side: const BorderSide(color:  TColors.primary),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    textStyle: const TextStyle(
        fontSize: TSizes.fontSizeLg, color: Colors.black, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ));

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    foregroundColor: Colors.white,
    side: const BorderSide(color:  Colors.orangeAccent),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    textStyle: const TextStyle(
        fontSize: TSizes.fontSizeLg, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ));
}
