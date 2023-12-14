import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:task/theme/text_style/text_style.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData themeData({
    String? fontFamily,

  }) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Col.primary,
        elevation: 1,
      ),

      // Scroll Bar Theme
      /*scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: MaterialStateProperty.all(true),
          radius: Radius.circular(30.px),
          thumbColor: MaterialStateProperty.all(Col.primary),
          thickness: MaterialStateProperty.all(8.px),
          trackColor: MaterialStateProperty.all(Col.primaryColor),
          trackVisibility: MaterialStateProperty.all(true),
          minThumbLength: 100.px,

        ),*/

      // Slider Theme
      /* sliderTheme: SliderThemeData(
          trackHeight: 8.px,
          activeTrackColor: Col.primary,
          inactiveTickMarkColor: Col.primaryColor,
          inactiveTrackColor: Col.primaryColor,
        ),*/

      textTheme: CommonTextTheme().textTheme(fontFamily: fontFamily),
      primaryColor: Col.primaryColor,
      scaffoldBackgroundColor: Col.scaffoldBackgroundColor,

      colorScheme: ColorScheme(
        primary: Col.primary,
        onPrimary: Col.primary,
        secondary: Col.secondary,
        onSecondary: Col.onSecondary,
        error: Col.error,
        brightness: Brightness.light,
        onError: Col.error,
        background: Col.scaffoldBackgroundColor,
        onBackground: Col.backgroundFillColor,
        surface: Col.borderColor,
        onSurface: Col.borderFillColor,
      ),

      textSelectionTheme: TextSelectionThemeData(cursorColor: Col.primary),

      /*inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(top: 1),
        constraints: BoxConstraints(maxHeight: 70.px),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: Col.primary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: Col.gray),
        ),
         errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Col.error),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Col.error),
          ),
      ),*/

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.px),
            ),
            padding: EdgeInsets.zero,
            foregroundColor: Col.primary),
      ),

       outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.px),
              ),
              foregroundColor: Col.text,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.all(3.5.px),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        ),

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Col.primary,
            foregroundColor: Col.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(C.outlineButtonRadius),
            ),
            minimumSize: Size(320.px, 46.px),
          )
      ),

    );
  }
}
