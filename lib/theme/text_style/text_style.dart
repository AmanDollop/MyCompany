import 'package:task/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextThemeStyle {
  static TextStyle displayLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 18.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle displayMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 18.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle displaySmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 18.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle bodyLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 16.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle bodyMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 16.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle bodySmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 16.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle titleLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 14.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle titleMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 14.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle titleSmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 14.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle labelLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 12.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      wordSpacing: 0.px,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle labelMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 12.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle labelSmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 12.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headlineLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 22.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headlineMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 24.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headlineSmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 24.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }
}

class CommonTextTheme {
  TextTheme textTheme({String? fontFamily}) {
    return TextTheme(
      //Headline:-22.px w600
      headlineLarge: TextThemeStyle.headlineLarge(
        Col.primary,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextThemeStyle.headlineMedium(
        Col.text,
        fontFamily: fontFamily,
      ),
      headlineSmall: TextThemeStyle.headlineSmall(
        Col.onText,
        fontFamily: fontFamily,
      ),
      //Display-according to need
      //Headline:-18.px w600
      displayLarge: TextThemeStyle.displayLarge(
        Col.text,
        fontFamily: fontFamily,
      ),
      //Headline:-18.px w600
      displayMedium: TextThemeStyle.displayMedium(
        Col.textGrayColor,
        fontFamily: fontFamily,
      ),
      //Headline:-18.px w600
      displaySmall: TextThemeStyle.displaySmall(
        Col.onText,
        fontFamily: fontFamily,
      ),
      //Body-16.px w700
      bodyLarge: TextThemeStyle.bodyLarge(
        Col.text,
        fontFamily: fontFamily,
      ),
      //Body-16.px w400
      bodyMedium: TextThemeStyle.bodyMedium(
        Col.textGrayColor,
        fontFamily: fontFamily,
      ),
      //Body-16.px w400
      bodySmall: TextThemeStyle.bodySmall(
        Col.text,
        fontFamily: fontFamily,
      ),
      //Title-14.px w500
        titleLarge: TextThemeStyle.titleLarge(
        Col.text,
        fontFamily: fontFamily,
      ),
      //Title-14.px w400
      titleMedium: TextThemeStyle.titleMedium(
        Col.textGrayColor,
        fontFamily: fontFamily,
      ),
      //Title-14.px w400
      titleSmall: TextThemeStyle.titleSmall(
        Col.text,
        fontFamily: fontFamily,
      ),
      //Label-12.px w400
      labelSmall: TextThemeStyle.labelLarge(
        Col.text,
        fontFamily: fontFamily,
      ),
      //Label-12.px w400
      labelMedium: TextThemeStyle.labelMedium(
        Col.textGrayColor,
        fontFamily: fontFamily,
      ),
      //Label-12.px w400
      labelLarge: TextThemeStyle. labelSmall(
        Col.onText,
        fontFamily: fontFamily,
      ),
    );
  }
}
