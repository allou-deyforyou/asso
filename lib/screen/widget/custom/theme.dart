import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fonts.gen.dart';

class Themes {
  const Themes._();

  static const Color primaryColor = Color(0xFF007AFF);
  static const Color secondaryColor = Color(0xFF000000);
  static const Color tertiaryColor = Color(0xFFFFFFFF);

  static const Color lightBarBackgroundColor = Color(0xFFF5F4FB);
  static const Color darkBarBackgroundColor = CupertinoColors.black;

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      brightness: Brightness.light,
      fontFamily: FontFamily.sFProRounded,
      canvasColor: CupertinoColors.white,
      scaffoldBackgroundColor: CupertinoColors.white,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        tertiary: tertiaryColor,
        onSecondary: CupertinoColors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        isDense: true,
        isCollapsed: true,
        fillColor: CupertinoColors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: CupertinoColors.systemFill)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: CupertinoColors.systemFill)),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: CupertinoColors.destructiveRed)),
      ),
      dividerTheme: const DividerThemeData(
        space: 0.8,
        thickness: 0.8,
        color: CupertinoColors.systemGrey5,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: lightBarBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        barBackgroundColor: lightBarBackgroundColor,
        textTheme: CupertinoTextThemeData(),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: primaryColor,
      brightness: Brightness.dark,
      fontFamily: FontFamily.sFProRounded,
      canvasColor: CupertinoColors.darkBackgroundGray,
      scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
      dividerTheme: const DividerThemeData(
        space: 0.8,
        thickness: 0.8,
        color: CupertinoColors.systemFill,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBarBackgroundColor,
      ),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: primaryColor,
        tertiary: tertiaryColor,
        onSecondary: CupertinoColors.white,
      ),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        barBackgroundColor: darkBarBackgroundColor,
        textTheme: CupertinoTextThemeData(),
      ),
    );
  }
}
