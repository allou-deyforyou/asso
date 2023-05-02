import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fonts.gen.dart';

class Themes {
  const Themes._();

  static const Color primaryColor = Color(0xFFFDB813); // Color(0xFF007AFF);
  static const Color secondaryColor = Color(0xFF000000);
  static const Color tertiaryColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFF5F2EF);

  static const Color lightBarBackgroundColor = Color(0xFFFCFBFE);
  static const Color darkBarBackgroundColor = CupertinoColors.black;

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: FontFamily.sFProRounded,
      canvasColor: CupertinoColors.white,
      scaffoldBackgroundColor: surfaceColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        tertiary: tertiaryColor,
        surface: CupertinoColors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        isDense: true,
        isCollapsed: true,
        fillColor: CupertinoColors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 0.8)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: CupertinoColors.systemFill, width: 0.8)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: CupertinoColors.systemFill, width: 0.8)),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: CupertinoColors.destructiveRed, width: 0.8)),
      ),
      dividerTheme: const DividerThemeData(
        space: 0.8,
        thickness: 0.8,
        color: Color(0xFFE0DEDB),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: surfaceColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        shape: Border(bottom: BorderSide(width: 0.8, color: CupertinoColors.systemGrey5)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: CupertinoColors.systemFill.withOpacity(0.2)),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
        ),
      ),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        barBackgroundColor: surfaceColor,
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
