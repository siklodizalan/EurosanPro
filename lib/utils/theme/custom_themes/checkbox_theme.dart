import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:flutter/material.dart';

class TCheckboxTheme {
  TCheckboxTheme._();

  static CheckboxThemeData lightCheckbocTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return  TColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );

  static CheckboxThemeData darkCheckbocTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return  TColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
