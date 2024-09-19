import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      color: Pallete.backgroundColor,
      elevation: 0,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Pallete.selectionColor,
      cursorColor: Pallete.cursorColor,
      selectionHandleColor: Pallete.buttonColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.buttonColor,
    ),
  );
}
