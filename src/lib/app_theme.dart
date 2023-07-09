import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption/utils/color_utils.dart';

// AppTheme class defines the light theme and dark theme that is used inside the app.
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: kPrimaryLightColor,
    hintColor: kTertiaryLightColor,
    iconTheme: const IconThemeData(color: kPrimaryDarkColor),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryLightColor,
      secondary: Colors.white,
      background: kPrimaryLightColor,
      tertiary: kTertiaryLightColor,
    ),
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Colors.white, elevation: 0),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: kBottomAppBarColor,
            disabledBackgroundColor: kBottomAppBarDisabledColor,
            padding: const EdgeInsets.symmetric(vertical: 12))),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: kPrimaryDarkColor),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      color: kPrimaryLightColor,
      iconTheme: IconThemeData(color: kPrimaryDarkColor),
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: kPrimaryDarkColor),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: kPrimaryDarkColor),
    textTheme: const TextTheme(
      headline2: TextStyle(
          fontSize: 22, color: kPrimaryDarkColor, fontWeight: FontWeight.w600),
      headline3: TextStyle(
          fontSize: 18, color: kPrimaryDarkColor, fontWeight: FontWeight.w600),
      headline4: TextStyle(
          fontSize: 16, color: kPrimaryDarkColor, fontWeight: FontWeight.w600),
      headline5: TextStyle(
          fontSize: 14, color: kPrimaryDarkColor, fontWeight: FontWeight.w600),
      bodyText1: TextStyle(
          fontSize: 14,
          color: kSecondaryTextColor,
          fontWeight: FontWeight.w500),
      bodyText2: TextStyle(
          fontSize: 12,
          color: kSecondaryTextColor,
          fontWeight: FontWeight.w500),
      subtitle1: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: kPrimaryDarkColor),
      subtitle2: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 10.0,
          color: kPrimaryDarkColor),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kPrimaryDarkColor,
    hintColor: kTertiaryDarkColor,
    iconTheme: const IconThemeData(color: kPrimaryLightColor),
    colorScheme: const ColorScheme.dark(
      primary: kPrimaryDarkColor,
      secondary: kSecondaryDarkColor,
      background: kPrimaryDarkColor,
      tertiary: kTertiaryDarkColor,
    ),
    bottomAppBarTheme:
        const BottomAppBarTheme(color: kSecondaryDarkColor, elevation: 0),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: kBottomAppBarColor,
            disabledBackgroundColor: kBottomAppBarDisabledColor,
            padding: const EdgeInsets.symmetric(vertical: 12))),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: kPrimaryLightColor),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      color: kPrimaryDarkColor,
      iconTheme: IconThemeData(color: kPrimaryLightColor),
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: kPrimaryLightColor),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: kPrimaryLightColor),
    textTheme: const TextTheme(
      headline2: TextStyle(
          fontSize: 22, color: kPrimaryLightColor, fontWeight: FontWeight.w600),
      headline3: TextStyle(
          fontSize: 18, color: kPrimaryLightColor, fontWeight: FontWeight.w600),
      headline4: TextStyle(
          fontSize: 16, color: kPrimaryLightColor, fontWeight: FontWeight.w600),
      headline5: TextStyle(
          fontSize: 14, color: kPrimaryLightColor, fontWeight: FontWeight.w600),
      bodyText1: TextStyle(
          fontSize: 14,
          color: kSecondaryTextColor,
          fontWeight: FontWeight.w500),
      bodyText2: TextStyle(
          fontSize: 12,
          color: kSecondaryTextColor,
          fontWeight: FontWeight.w500),
      subtitle1: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: kPrimaryLightColor),
      subtitle2: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 10.0,
          color: kPrimaryLightColor),
    ),
  );
}
