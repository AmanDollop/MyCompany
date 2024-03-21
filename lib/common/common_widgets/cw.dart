import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/custom_outlinebutton/cub.dart';
import 'package:task/common/common_packages/rating/rating_bar.dart';
import 'package:task/common/common_packages/read_more/read_more.dart';
import 'package:task/common/common_packages/scroll_behavior/scroll_behavior.dart';
import 'package:task/common/common_packages/shimmer/shimmer.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/common/gradient_image_convert.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../common_packages/rating/rating_bar_indicator.dart';

class CW {
  /// --------------------------Common Button(Elevated,Outline,Text,IconButton) Collection-----------------------

  static apiColorConverterMethod({required String colorString,colorCodeWithHundredPerValue = true}) {
    String formattedColor = colorString.startsWith('#') ? colorString.substring(1) : colorString;

    // Parse the hexadecimal value and create a Color object
    if(colorCodeWithHundredPerValue) {
      return Color(int.parse('0xFF$formattedColor'));
    }else{
      return Color(int.parse('0x14$formattedColor'));
    }
  }

  ///For Full Size Use In Column Not In Row
  static Widget commonElevatedButton(
      {double? height,
      double? width,
      double? progressBarHeight,
      double? progressBarWidth,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double? borderRadius,
      Color? splashColor,
      Color? buttonColor,
      Color? buttonTextColor,
      double? elevation,
      bool isContentSizeButton = true,
      required VoidCallback onPressed,
      Widget? child,
      String? buttonText,
      bool isLoading = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation ?? 0.px,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? C.radius),
        ),
        backgroundColor: buttonColor ?? Col.primary,
        foregroundColor: splashColor ?? Colors.white,
        minimumSize: Size(width ?? double.infinity, height ?? 46.px),
        shadowColor: Colors.transparent,
      ),
      child: isLoading
          ? Center(
              child: SizedBox(
                height: progressBarHeight ?? 24.px,
                width: progressBarWidth ?? 24.px,
                child: CW.commonProgressBarView(color: Col.inverseSecondary, backgroundColor: Col.gray),
              ),
            )
          : child ??
              Text(
                buttonText ?? '',
                style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 14.px, color: buttonTextColor),
              ),
    );
  }

  static Widget myElevatedButton(
      {required VoidCallback onPressed,
      double? height,
      double? width,
      double? progressBarHeight,
      double? progressBarWidth,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double? borderRadius,
      Color? splashColor,
      Color? buttonColor,
      Color? buttonTextColor,
      double? elevation,
      bool isContentSizeButton = true,
      Widget? child,
      String? buttonText,
      bool isLoading = false}) {
    return Container(
      height: height ?? 46.px,
      // margin: margin ?? EdgeInsets.symmetric(horizontal: Zconstant.margin),
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        gradient: commonLinearGradientForButtonsView(),
        borderRadius: BorderRadius.circular(borderRadius ?? C.radius),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0.px,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? C.radius),
          ),
          backgroundColor: buttonColor ?? Colors.transparent,
          foregroundColor: splashColor ?? Colors.transparent,
          minimumSize: Size(width ?? double.infinity, height ?? 46.px),
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: progressBarHeight ?? 24.px,
                  width: progressBarWidth ?? 24.px,
                  child: CW.commonProgressBarView(
                      color: Col.gBottom, backgroundColor: Col.gray),
                ),
              )
            : child ??
                Text(
                  buttonText ?? '',
                  style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 14.px, color: buttonTextColor ?? Col.text),
                ),
      ),
    );
  }

  static Widget myOutlinedButton(
      {required VoidCallback onPressed,
      double? strokeWidth,
      double? height,
      double? width,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double? radius,
      bool wantFixedSize = true,
      double? progressBarHeight,
      double? progressBarWidth,
      Widget? child,
      String? buttonText,
      bool isLoading = false,
      Color? buttonTextColor,
      LinearGradient? linearGradient}) {
    return wantFixedSize
        ? SizedBox(
            height: height ?? 50.px,
            width: width ?? double.infinity,
            // margin: margin ?? EdgeInsets.symmetric(horizontal: 20.px),
            child: CustomOutlineButton(
              onPressed: onPressed,
              strokeWidth: strokeWidth ?? 1,
              radius: radius ?? 25.px,
              gradient: linearGradient ?? commonLinearGradientForButtonsView(),
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        height: progressBarHeight ?? 24.px,
                        width: progressBarWidth ?? 24.px,
                        child: CW.commonProgressBarView(
                            color: Col.inverseSecondary,
                            backgroundColor: Col.gray),
                      ),
                    )
                  : child ??
                      Text(
                        buttonText ?? '',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontSize: 14.px, color: buttonTextColor),
                      ),
            ),
          )
        : SizedBox(
            height: height ?? 50.px,
            // margin: margin ?? EdgeInsets.symmetric(horizontal: 20.px),
            child: CustomOutlineButton(
              onPressed: onPressed,
              strokeWidth: strokeWidth ?? 1,
              padding: padding,
              radius: radius ?? 25.px,
              gradient: linearGradient ?? commonLinearGradientForButtonsView(),
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        height: progressBarHeight ?? 24.px,
                        width: progressBarWidth ?? 24.px,
                        child: CW.commonProgressBarView(
                            color: Col.inverseSecondary,
                            backgroundColor: Col.gray),
                      ),
                    )
                  : child ??
                      Text(
                        buttonText ?? '',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontSize: 14.px, color: buttonTextColor),
                      ),
            ),
          );
  }

  static Widget myCommonTabBarView({required String tabBarValue,
    required String tab1ButtonText,
    required String tab2ButtonText,
    required VoidCallback tab1ButtonOnPressed,
    required VoidCallback tab2ButtonOnPressed}){
    return  AnimatedContainer(
      height: 44.px,
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: 6.px),
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.px)),
      duration: const Duration(milliseconds: 500),
      child: Row(
        children: [
          Expanded(
            child: tabBarValue != tab1ButtonText
                ? tabBarTextButtonText(buttonText: tab1ButtonText, onPressed: tab1ButtonOnPressed)
                : CW.tabBarElevatedButtonText(
              onPressed: tab1ButtonOnPressed,
              buttonText: tab1ButtonText,
            ),
          ),
          SizedBox(width: 8.px),
          Expanded(
            child: tabBarValue != tab2ButtonText
                ? tabBarTextButtonText(buttonText: tab2ButtonText, onPressed: tab2ButtonOnPressed)
                : CW.tabBarElevatedButtonText(
              onPressed: tab2ButtonOnPressed,
              buttonText: tab2ButtonText,
            ),
          ),
        ],
      ),
    );
  }

  static Widget tabBarTextButtonText({required String buttonText,required VoidCallback onPressed}){
    return CustomOutlineButton(
      onPressed: onPressed,
      radius: 14.px,
      gradient: CW.commonLinearGradientForButtonsView(),
      strokeWidth: 1.px,
      padding: EdgeInsets.zero,child:  Text(
      buttonText,
      style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 14.px, color: Col.inverseSecondary),
     ),
    );

 }

  static Widget tabBarElevatedButtonText({required String buttonText,required VoidCallback onPressed}){
    return  CW.myElevatedButton(
     onPressed: onPressed,
     height: 40.px,
     buttonText: buttonText,
     borderRadius: 14.px,
     buttonTextColor: Col.text,
  );
 }

  static Widget commonFloatingActionButton({required IconData icon, required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.px),
      child: Container(
        height: 50.px,
        // margin: margin ?? EdgeInsets.symmetric(horizontal: Zconstant.margin),
        width: 50.px,
        decoration: BoxDecoration(
            gradient: commonLinearGradientForButtonsView(),
            shape: BoxShape.circle),
        child: CW.commonOutlineButton(
            onPressed: onPressed,
            child: Icon(
              icon,
              color: Col.inverseSecondary,
              size: 22.px,
            ),
            height: 50.px,
            width: 50.px,
            backgroundColor: Colors.transparent,
            borderColor: Colors.transparent,
            borderRadius: 25.px),
      ),
    );
  }

  static Widget commonOutlineButton(
      {double? height,
      double? width,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double? borderRadius,
      double? borderWidth,
      Color? borderColor,
      Color? backgroundColor,
      Color? buttonTextColor,
      double? elevation,
      bool isContentSizeButton = true,
      required VoidCallback onPressed,
      Widget? child,
      String? buttonText,
      bool isLoading = false}) {
    return isLoading
        ? CW.commonProgressBarView(color: borderColor ?? Col.primary)
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              elevation: elevation ?? 0.px,
              padding: padding ?? EdgeInsets.all(3.5.px),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    borderRadius ?? C.outlineButtonRadius),
              ),
              side: BorderSide(
                color: borderColor ?? Col.text,
                width: borderWidth ?? 1.5.px,
              ),
              backgroundColor: backgroundColor ?? Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Col.text,
              minimumSize: Size(
                width ?? 56.px,
                height ?? 56.px,
              ),
            ),
            child: child ??
                Text(
                  buttonText ?? '',
                  style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: buttonTextColor),
                ),
          );
  }

  static Widget commonTextButton(
      {double? height,
      double? width,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double? borderRadius,
      double? elevation,
      bool isContentSizeButton = true,
      required VoidCallback onPressed,
      required Widget child}) {
    return Container(
      height: height,
      width: isContentSizeButton ? width : double.infinity,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? C.textButtonRadius),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: elevation ?? 0.px,
          padding: padding ?? EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? C.textButtonRadius),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Col.primary,
          shadowColor: Colors.transparent,
        ),
        child: child,
      ),
    );
  }

  static Widget commonIconButton({
    required VoidCallback onPressed,
    required bool isAssetImage,
    double? size,
    double? width,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    String? imagePath,
    IconData? icon,
    Color? color,
    Color? splashColor,
  }) => IconButton(
        onPressed: onPressed,
        splashRadius: size != null ? size + 4.px : 24.px,
        icon: imagePath != null && imagePath.isNotEmpty
            ? CW.commonNetworkImageView(
                path: imagePath,
                isAssetImage: isAssetImage,
                color: color,
                width: width ?? 20.px,
                height: size ?? 20.px,
              )
            : Icon(
                icon,
                size: size ?? 20.px,
                color: color ?? Col.gray,
              ),
        padding: padding,
        // constraints: BoxConstraints(maxHeight: size ?? 20.px, minWidth: width ?? size ?? 20.px),
        splashColor: splashColor,
      );

  /// --------------------------Common Gradiant Button Collection--------------------------

  ///Gradiant Section
  static LinearGradient commonLinearGradientView() => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 0.4],
      tileMode: TileMode.decal,
      colors: [
        Col.gTop,
        Col.gBottom,
      ],
      );

  static LinearGradient commonLinearGradientForButtonsView() => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.0, 0.8],
        colors: [
          Col.primary,
          Col.primaryColor,
        ],
      );

  static Widget commonGradiantOutlineButton(
      {double? height,
      double? width,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double? borderRadius,
      double? borderWidth,
      Color? borderColor,
      double? elevation,
      bool isContentSizeButton = true,
      required VoidCallback onPressed,
      required Widget child,
      bool isLoading = false}) {
    return Container(
      height: isContentSizeButton ? height : 54.px,
      width: isContentSizeButton ? width : double.infinity,
      margin: margin ?? EdgeInsets.zero,
      padding: EdgeInsets.zero,
      alignment: isLoading ? Alignment.center : null,
      decoration: BoxDecoration(
        borderRadius: isLoading
            ? null
            : BorderRadius.circular(
                isContentSizeButton ? 20.px : borderRadius ?? C.buttonRadius),
        shape: isLoading ? BoxShape.circle : BoxShape.rectangle,
        border: Border.all(
          width: borderWidth ?? 1.px,
          color: Colors.transparent,
        ),
      ),
      child: isLoading
          ? CW.commonProgressBarView(color: borderColor ?? Col.primary)
          : CUB(
              onPressed: onPressed,
              strokeWidth: borderWidth ?? 1.px,
              radius:
                  isContentSizeButton ? 20.px : borderRadius ?? C.buttonRadius,
              padding: isLoading ? EdgeInsets.zero : padding,
              elevation: elevation,
              gradient: commonLinearGradientView(),
              child: child,
            ),
    );
  }

  static Widget commonGradiantElevatedButton(
      {double? height,
      double? width,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double? borderRadius,
      Color? splashColor,
      double? elevation,
      bool isContentSizeButton = true,
      required VoidCallback onPressed,
      required Widget child,
      bool isLoading = false}) {
    return Container(
      height: isContentSizeButton ? height : 54.px,
      width: isContentSizeButton ? width : double.infinity,
      margin: margin,
      alignment: isLoading ? Alignment.center : null,
      decoration: BoxDecoration(
        gradient: commonLinearGradientView(),
        borderRadius: isLoading
            ? null
            : BorderRadius.circular(borderRadius ?? C.buttonRadius),
        shape: isLoading ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: isLoading
          ? CW.commonProgressBarView(color: Colors.transparent)
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: elevation ?? 0.px,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: padding,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(borderRadius ?? C.buttonRadius),
                ),
                backgroundColor: Colors.transparent,
                foregroundColor: splashColor ?? Colors.white,
                shadowColor: Colors.transparent,
              ),
              child: child,
            ),
    );
  }

  /// --------------------------Common Refresh Indicator/Progress Bar Collection--------------------------
  static Widget commonRefreshIndicator({required Widget child, required RefreshCallback onRefresh}) {
    return RefreshIndicator(onRefresh: onRefresh, child: child);
  }

  static Widget commonLinearProgressBar({required double value, double? height}) => ClipRRect(
        borderRadius: BorderRadius.circular(20.px),
        child: LinearProgressIndicator(
          color: Col.primary,
          backgroundColor: Col.primary.withOpacity(.1),
          value: value,
          minHeight: height ?? 10.px,
        ),
      );

  static commonProgressBarView(
          {Color? color,
          Color? backgroundColor,
          double? value,
          double? strokeWidth}) => CircularProgressIndicator(
        backgroundColor: backgroundColor ?? Col.gray,
        color: color ?? Col.inverseSecondary,
        value: value,
        strokeWidth: strokeWidth ?? 3,
        strokeCap: StrokeCap.round,
      );

  static commonScaffoldBackgroundColor({required Widget child}) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.4],
          tileMode: TileMode.decal,
          colors: [
            Col.gTop,
            Col.gBottom,
          ],
        ),
      ),
      child: child,
    );
  }

  /// --------------------------Common TextField Collection--------------------------
  static Widget commonTextField(
      {String? hintText,
      TextStyle? hintStyle,
      TextStyle? errorStyle,
      String? labelText,
      String? hideTextCharacter,
      TextStyle? labelStyle,
      TextStyle? style,
      TextEditingController? controller,
      ValueChanged<String>? onChanged,
      FormFieldValidator<String>? validator,
      TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters,
      TextCapitalization textCapitalization = TextCapitalization.sentences,
      GestureTapCallback? onTap,
      Widget? prefixIcon,
      String? prefixIconPath,
      Widget? suffixIcon,
      EdgeInsetsGeometry? contentPadding,
      EdgeInsetsGeometry? suffixPadding,
      EdgeInsetsGeometry? prefixPadding,
      Color? fillColor,
      Color? initialBorderColor,
      double? initialBorderWidth,
      double? borderRadius,
      double? cursorHeight,
      bool isBorder = true,
      bool autofocus = false,
      bool isSearchLabelText = true,
      bool readOnly = false,
      bool filled = true,
      bool isUnderlineBorder = false,
      bool isHideText = false,
      bool isCountrySelection = false,
      FocusNode? focusNode,
      VoidCallback? clickOnArrowDown,
      String selectedCountryCode = "",
      String countryFlagPath = "",
      int? maxLength}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Theme(
          data: ThemeData(),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                // Update label color based on focus
              });
            },
            child: TextFormField(
              cursorHeight: cursorHeight,
              onTap: onTap,
              focusNode: focusNode,
              controller: controller,
              onChanged: keyboardType == TextInputType.number
                  ? (value) {}
                  : onChanged ?? (value) {
                        value = value.trim();
                        if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
                          controller?.text = "";
                        }
                      },
              obscureText: isHideText,
              obscuringCharacter: hideTextCharacter ?? '•',
              validator: validator,
              keyboardType: keyboardType,
              readOnly: readOnly,
              autofocus: autofocus,
              inputFormatters: keyboardType == TextInputType.number
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : inputFormatters,
              textCapitalization: textCapitalization,
              style: style ?? Theme.of(context).textTheme.titleLarge?.copyWith(color: Col.inverseSecondary),
              maxLength: maxLength,
              decoration: isUnderlineBorder
                  ? InputDecoration(
                      labelText: isSearchLabelText ? '' : labelText,
                      errorStyle: errorStyle ?? Theme.of(context).textTheme.labelMedium?.copyWith(color: Col.error),
                      labelStyle: labelStyle ?? Theme.of(context).textTheme.titleMedium,
                      hintText: hintText,
                      fillColor: fillColor ?? Colors.transparent,
                      filled: filled ? true : false,
                      contentPadding: contentPadding ?? EdgeInsets.only(left: 8.px, right: 8.px, top: 3.px),
                      hintStyle: hintStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(color: Col.inverseSecondary),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.inverseSecondary, width: 1.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              borderRadius ?? C.textFieldRadius)),
                      border: UnderlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.primary, width: 1.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              borderRadius ?? C.textFieldRadius)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(
                                  color: filled
                                      ? initialBorderColor ?? Col.inverseSecondary
                                      : Col.secondary,
                                  width: initialBorderWidth ?? 1.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              borderRadius ?? C.textFieldRadius)),
                      errorBorder: UnderlineInputBorder(
                        borderSide: isBorder
                            ? BorderSide(color: Col.error, width: 1.px)
                            : BorderSide.none,
                        borderRadius: BorderRadius.circular(
                            borderRadius ?? C.textFieldRadius),
                      ),
                      constraints: labelText != null && labelText.isNotEmpty
                          ? null
                          : BoxConstraints(maxHeight: 38.px),
                      /* suffixIconConstraints: BoxConstraints(maxHeight: 45.px),

                    prefixIconConstraints: BoxConstraints(maxHeight: 80.px,minHeight: 80.px),*/

                      suffixIcon: Padding(
                        padding: suffixPadding ?? EdgeInsets.zero,
                        child: suffixIcon,
                      ),
                      prefixIcon: prefixIcon != null
                          ? Padding(
                              padding: prefixPadding ?? EdgeInsets.zero,
                              child: prefixIcon,
                            )
                          : null,
                    )
                  : InputDecoration(
                      counterText: '',
                      labelText: labelText,
                      labelStyle: labelStyle ??
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: focusNode?.hasFocus == true /*|| (controller?.text != null && controller!.text.isNotEmpty)*/
                                    ? Col.primary
                                    : Col.gray,
                              ),
                      errorStyle: errorStyle ?? Theme.of(context).textTheme.labelMedium?.copyWith(color: Col.error),
                      hintText: hintText,
                      fillColor: focusNode?.hasFocus == true
                          ? Col.primary.withOpacity(.1)
                          : Colors.transparent,
                      filled: filled,
                      contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.px),
                      hintStyle: hintStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(color: Col.inverseSecondary),
                      disabledBorder: OutlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.gray, width: 1.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              borderRadius ?? C.textFieldRadius)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.primary, width: 1.5.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              borderRadius ?? C.textFieldRadius)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.error, width: 1.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              borderRadius ?? C.textFieldRadius)),
                      border: OutlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.primary, width: 1.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              borderRadius ?? C.textFieldRadius)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(
                                  color: filled
                                      ? initialBorderColor ?? Col.gray
                                      : Col.secondary,
                                  width: initialBorderWidth ?? 1.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
                      errorBorder: OutlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.error, width: 1.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
                      suffixIcon: suffixIcon != null
                          ? Padding(
                              padding: suffixPadding ?? EdgeInsets.zero,
                              child: suffixIcon,
                            )
                          : null,
                      prefixIcon: prefixIcon != null
                          ? Padding(
                              padding: prefixPadding ?? EdgeInsets.zero,
                              child: isCountrySelection
                                  ? InkWell(
                                      onTap: clickOnArrowDown,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(width: 10.px),
                                            Icon(Icons.arrow_drop_down,
                                                size: 26.px,
                                                color:
                                                    focusNode?.hasFocus == true
                                                        ? Col.primary
                                                        : Col.inverseSecondary),
                                            Center(
                                              child: CW.commonNetworkImageView(
                                                  path: countryFlagPath,
                                                  isAssetImage: false,
                                                  height: 14.px,
                                                  width: 20.px),
                                            ),
                                            SizedBox(width: 4.px),
                                            Text(selectedCountryCode,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                        color: Col
                                                            .inverseSecondary)),
                                            SizedBox(width: 6.px),
                                            VerticalDivider(
                                              width: 2,
                                              indent: 10.px,
                                              endIndent: 10.px,
                                              color: Col.inverseSecondary,
                                              thickness: 1.px,
                                            ),
                                            SizedBox(width: 10.px),
                                          ],
                                        ),
                                      ),
                                    )
                                  : prefixIconPath != null && prefixIconPath.isNotEmpty
                                      ? focusNode?.hasFocus == true
                                          ? SizedBox(
                                width: 24.px,
                                height: 24.px,
                                child: Center(
                                  child: GradientImageWidget(
                                    assetPath: prefixIconPath,
                                    width: 24.px,
                                    height: 24.px,
                                  ),
                                ),
                              )
                                          : commonIconImage(imagePath: prefixIconPath, color: Col.inverseSecondary)
                                      : prefixIcon,
                            )
                          : isCountrySelection
                              ? InkWell(
                                  onTap: clickOnArrowDown,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: 10.px),
                                        Text(selectedCountryCode,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    color:
                                                        Col.inverseSecondary)),
                                        SizedBox(width: 4.px),
                                        Icon(Icons.keyboard_arrow_down,
                                            size: 20.px,
                                            color: focusNode?.hasFocus == true
                                                ? Col.primary
                                                : Col.inverseSecondary),
                                        SizedBox(width: 4.px),
                                        VerticalDivider(
                                          width: 2,
                                          indent: 10.px,
                                          endIndent: 10.px,
                                          color: Col.inverseSecondary,
                                          thickness: 2.px,
                                        ),
                                        SizedBox(width: 10.px),
                                      ],
                                    ),
                                  ),
                                )
                              : prefixIconPath != null && prefixIconPath.isNotEmpty
                               ? focusNode?.hasFocus == true
                                      ? SizedBox(
                                          width: 24.px,
                                          height: 24.px,
                                          child: Center(
                                            child: GradientImageWidget(
                                              assetPath: prefixIconPath,
                                              width: 24.px,
                                              height: 24.px,
                                            ),
                                          ),
                                        )
                                      : commonIconImage(imagePath: prefixIconPath, color: Col.inverseSecondary)
                                  : prefixIcon,
                    ),
            ),
          ),
        );
      },
    );
  }

  static Widget commonIconImage({required String imagePath, Color? color}) => SizedBox(
        width: 24.px,
        height: 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: true,
              width: 24.px,
              height: 24.px,
              color: color),
        ),
      );

  static Widget commonTextFieldForMultiline({
    String? hintText,
    TextStyle? hintStyle,
    FocusNode? focusNode,
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? style,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.sentences,
    GestureTapCallback? onTap,
    Widget? prefixIcon,
    String? prefixIconPath,
    Widget? suffixIcon,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? suffixPadding,
    EdgeInsetsGeometry? prefixPadding,
    Color? fillColor,
    Color? initialBorderColor,
    double? initialBorderWidth,
    double? borderRadius,
    double? cursorHeight,
    double? maxHeight,
    int? maxLines,
    int? minLines,
    double? elevation,
    bool isBorder = true,
    bool autofocus = false,
    bool readOnly = false,
    bool filled = true,
    bool isSearchLabelText = true,
    TextInputAction? textInputAction,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Theme(
          data: ThemeData(),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                print('controller:::  ${controller?.text}');
              });
            },
            child: SizedBox(
              height: maxHeight,
              child: Card(
                elevation: elevation ?? 0.px,
                margin: EdgeInsets.zero,
                color: Colors.transparent,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        borderRadius ?? C.textFieldRadius),
                    borderSide: BorderSide.none),
                child: TextFormField(
                  textInputAction: textInputAction,
                  cursorHeight: cursorHeight,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  controller: controller,
                  maxLines: maxLines,
                  minLines: minLines,
                  validator: validator,
                  keyboardType: keyboardType,
                  readOnly: readOnly,
                  autofocus: autofocus,
                  inputFormatters: inputFormatters,
                  textCapitalization: textCapitalization,
                  style: style ?? Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.inverseSecondary),
                  decoration: InputDecoration(
                      labelText: isSearchLabelText ? '' : labelText,
                      labelStyle: labelStyle ?? Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: focusNode?.hasFocus == true /*|| (controller?.text != null && controller!.text.isNotEmpty)*/ ? Col.primary : Col.gray,),
                      errorStyle: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.error),
                      hintText: hintText,
                      fillColor: focusNode?.hasFocus == true
                          ? Col.primary.withOpacity(.1)
                          : Colors.transparent,
                      filled: filled,
                      contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.px, vertical: 10.px),
                      hintStyle: hintStyle ?? Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Col.inverseSecondary),
                      disabledBorder: OutlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.gray, width: 1.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              borderRadius ?? C.textFieldRadius)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.primary, width: 1.5.px)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              borderRadius ?? C.textFieldRadius)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: isBorder
                              ? BorderSide(color: Col.error, width: 1.px)
                              : BorderSide.none,
                          borderRadius:
                              BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
                      border: OutlineInputBorder(borderSide: isBorder ? BorderSide(color: Col.primary, width: 1.px) : BorderSide.none, borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
                      enabledBorder: OutlineInputBorder(borderSide: isBorder ? BorderSide(color: filled ? initialBorderColor ?? Col.gray : Col.secondary, width: initialBorderWidth ?? 1.px) : BorderSide.none, borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
                      errorBorder:  OutlineInputBorder(borderSide: isBorder
                           ? BorderSide(color: Col.error, width: 1.px)
                          : BorderSide.none, borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius),
                      ),
                      suffixIcon: suffixIcon != null
                          ? Padding(
                              padding: suffixPadding ?? EdgeInsets.zero,
                              child: suffixIcon,
                            )
                          : null,
                      prefixIcon: prefixIconPath != null && prefixIconPath.isNotEmpty ?
                      focusNode?.hasFocus == true
                          ? SizedBox(
                        width: 24.px,
                        height: 24.px,
                        child: Center(
                          child: GradientImageWidget(
                            assetPath: prefixIconPath,
                            width: 24.px,
                            height: 24.px,
                          ),
                        ),
                      )
                          : commonIconImage(
                          imagePath: prefixIconPath,
                          color: Col.inverseSecondary) : prefixIcon),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static myAppBarView(
      {VoidCallback? onActionButtonPressed,
      String? actionButtonImagePath,
      bool actionValue = false,
      bool homeValue = false,
      VoidCallback? onLeadingPressed,
      String? leadingButtonImagePath,
      required String title,
      EdgeInsetsGeometry? padding,
      Widget? action}) {
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: 24.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              homeValue
                  ? InkWell(
                      onTap: onLeadingPressed,
                      child: CW.commonNetworkImageView(
                          path: 'assets/icons/drawer_menu_icon.png',
                          isAssetImage: true,
                          height: 24.px,
                          width: 24.px,
                          color: Col.inverseSecondary),
                    )
                  : Container(
                      height: 40.px,
                      width: 40.px,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.8],
                          colors: [
                            Col.primary,
                            Col.primaryColor,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: onLeadingPressed,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            maximumSize: Size(40.px, 40.px),
                          ),
                          splashRadius: 24.px,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Col.text,
                            size: 22.px,
                          ),
                        ),
                      ),
                    ),
              SizedBox(width: 16.px),
              if (homeValue)
                CW.commonNetworkImageView(
                    path: 'assets/images/logo.png',
                    isAssetImage: true,
                    height: 24.px,
                    width: 24.px),
              if (homeValue) SizedBox(width: 5.px),
              Text(
                title,
                style: Theme.of(Get.context!)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 16.px),
              ),
            ],
          ),
          if (actionValue)
            action ??
                SizedBox(
                  height: 44.px,
                  width: 44.px,
                  child: Center(
                    child: InkWell(
                      onTap: onActionButtonPressed,
                      borderRadius: BorderRadius.circular(22.px),
                      child: Center(
                        child: CW.commonNetworkImageView(
                            path: actionButtonImagePath ?? '',
                            isAssetImage: true,
                            width: 20.px,
                            height: 24.px),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  /// --------------------------Common AppBar/Otp/BottomBar/Banner/PageView/TabBar Collection--------------------------
  static AppBar commonAppBarView({
    required String title,
    TextStyle? titleStyle,
    VoidCallback? onBackPressed,
    VoidCallback? onNotificationPressed,
    Widget? leading,
    List<Widget>? actions,
    PreferredSizeWidget? tabBar,
    Color? backgroundColor,
    Color? toolBarColor,
    Color? shadowColor,
    double? elevation,
    double? leadingWidth,
    double titleSpacing = 0.0,
    bool centerTitle = false,
    bool isLeading = false,
    bool homeAppBarValue = false,
  }) => homeAppBarValue
          ? AppBar(
              title: Row(
                children: [
                  commonNetworkImageView(
                      path: 'assets/images/logo.png',
                      isAssetImage: true,
                      height: 24.px,
                      width: 24.px),
                  SizedBox(width: 5.px),
                  Text(
                    title,
                    style: titleStyle ??
                        Theme.of(Get.context!)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontSize: 16.px),
                  ),
                ],
              ),
              bottom: tabBar,
              elevation: elevation,
              centerTitle: centerTitle,
              leading: leading,
              actions: actions ??
                  [
                    Center(
                      child: SizedBox(
                        height: 44.px,
                        width: 44.px,
                        child: Center(
                          child: InkWell(
                            onTap: onNotificationPressed,
                            borderRadius: BorderRadius.circular(22.px),
                            child: Center(
                              child: commonNetworkImageView(
                                  path: 'assets/icons/notification_iocn.png',
                                  isAssetImage: true,
                                  width: 44.px,
                                  height: 44.px),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.px)
                  ],
              leadingWidth: leadingWidth ?? 70.px,
              backgroundColor: backgroundColor ?? Col.primary,
              flexibleSpace: Container(
                  height: CM.getToolBarSize(),
                  color: toolBarColor ?? backgroundColor ?? Col.primary),
              titleSpacing: leading != null ? 0 : 0,
              shadowColor: shadowColor ?? Col.secondary,
            )
          : AppBar(
              title: Text(
                title,
                style: titleStyle ??
                    Theme.of(Get.context!)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontSize: 16.px),
              ),
              bottom: tabBar,
              elevation: elevation,
              centerTitle: centerTitle,
              leading: isLeading
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: C.margin / 2),
                      child: SizedBox(
                        height: 45.px,
                        width: 45.px,
                        child: Center(
                          child: leading ??
                              IconButton(
                                onPressed: onBackPressed,
                                style: IconButton.styleFrom(
                                  backgroundColor: Col.inverseSecondary,
                                  maximumSize: Size(45.px, 45.px),
                                ),
                                splashRadius: 24.px,
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Col.secondary,
                                  size: 22.px,
                                ),
                              ),
                        ),
                      ),
                    )
                  : leading,
              actions: actions,
              leadingWidth: leadingWidth ?? 70.px,
              backgroundColor: backgroundColor ?? Col.primary,
              flexibleSpace: Container(height: CM.getToolBarSize(), color: toolBarColor ?? backgroundColor ?? Col.primary),
              titleSpacing: leading != null ? titleSpacing ?? 0.px : titleSpacing,
              shadowColor: shadowColor ?? Col.secondary,
            );

  static Widget commonBottomBarView({
    required BuildContext context,
    required List<BottomNavigationBarItem> items,
    required ValueChanged<int>? onTap,
    required int selectedViewIndex,
    TextStyle? unLabelStyle,
    TextStyle? seLabelStyle,
    Color? backgroundColor,
    double elevation = 0,
    double? height,
    double? borderRadius,
  }) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius ?? 0.px),
          topRight: Radius.circular(borderRadius ?? 0.px),
        ),
        child: BottomNavigationBar(
          backgroundColor: backgroundColor ?? Col.primaryColor.withOpacity(0.5),
          currentIndex: selectedViewIndex,
          elevation: elevation,
          unselectedLabelStyle: unLabelStyle ?? Theme.of(context).textTheme.titleSmall,
          selectedLabelStyle: seLabelStyle ?? Theme.of(context).textTheme.titleSmall?.copyWith(color: Col.primary),
          type: BottomNavigationBarType.fixed,
          items: items,
          onTap: onTap,
        ),
      ),
    );
  }

  static BottomNavigationBarItem commonBottomBarItemView(
      {required String? imagePath,
      required IconData? icon,
      required bool isSelected,
      String label = "Home",
      double? height,
      double? width,
      Color? selectedColor,
      Color? unselectedColor}) {
    return BottomNavigationBarItem(
        icon: imagePath != null && imagePath.isNotEmpty
            ? Image.asset(
                imagePath,
                height: height,
                width: width,
                color: isSelected
                    ? selectedColor ?? Col.primary
                    : unselectedColor ?? Col.secondary,
              )
            : Icon(icon,
                size: height,
                color: isSelected
                    ? selectedColor ?? Col.primary
                    : unselectedColor ?? Col.secondary),
        label: label);
  }

  static TabBar commonTabBar({
    required TabController tabController,
    required List<Widget> tabs,
    ValueChanged<int>? onTap,
    ScrollPhysics? physics,
    Decoration? indicatorDecoration,
    TabBarIndicatorSize tabBarIndicatorSize = TabBarIndicatorSize.tab,
    TabAlignment tabAlignment = TabAlignment.fill,
    EdgeInsetsGeometry? indicatorPadding,
    EdgeInsetsGeometry? tabPadding,
    double? indicatorWeight,
    Color? indicatorColor,
    Color? selectedLabelColor,
    Color? unselectedLabelColor,
    TextStyle? selectedLabelStyle,
    TextStyle? unselectedLabelStyle,
    bool isScrollable = false,
  }) => TabBar(
        physics: physics ?? const ScrollPhysics(),
        onTap: onTap,
        isScrollable: isScrollable,
        automaticIndicatorColorAdjustment: true,
        indicatorPadding: indicatorPadding ?? EdgeInsets.zero,
        padding: tabPadding ?? EdgeInsets.zero,
        indicatorWeight: indicatorWeight ?? 4.px,
        indicatorColor: indicatorColor ?? Col.inverseSecondary,
        labelColor: selectedLabelColor ?? Col.inverseSecondary,
        unselectedLabelColor: selectedLabelColor ?? Col.secondary,
        labelStyle:
            selectedLabelStyle ?? Theme.of(Get.context!).textTheme.bodySmall,
        unselectedLabelStyle:
            unselectedLabelStyle ?? Theme.of(Get.context!).textTheme.bodySmall,
        tabAlignment: tabAlignment,
        indicatorSize: tabBarIndicatorSize,
        indicator: indicatorDecoration,
        tabs: tabs,
        controller: tabController,
      );

  ///flutter pub add carousel_slider :- For Banner
  static Widget commonBannerView({
    required List<String> imageList,
    required int selectedIndex,
    EdgeInsetsGeometry? padding,
    required Function(int index, CarouselPageChangedReason reason)?onPageChanged,
    CarouselController? carouselController,
    double? height,
    double? borderRadius,
    bool autoPlay = true,
    bool isIndicator = true,
    double? indicatorHeight,
    double? indicatorWidth,
    double? indicatorBottomPadding,
    double? indicatorSpace,
    double? indicatorCornerRadius,
    Color? indicatorActiveColor,
    Color? indicatorInactiveColor,
    int indicatorAnimationDuration = 300,
  }) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.px),
            child: CarouselSlider(
              items: imageList.isNotEmpty
                  ? imageList.map((image) {
                      return Padding(
                        padding: padding ??
                            EdgeInsets.symmetric(
                                horizontal: C.outlineButtonRadius),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(borderRadius ?? 12.px),
                          child: Material(
                            color: Col.gray.withOpacity(.1),
                            child: CW.commonNetworkImageView(
                                path: image,
                                isAssetImage: false,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: height ?? 145.px),
                          ),
                        ),
                      );
                    }).toList()
                  : [],
              carouselController: carouselController,
              options: CarouselOptions(
                autoPlay: autoPlay,
                height: height ?? 145.px,
                // enlargeCenterPage: true,
                viewportFraction: 1,
                onPageChanged: onPageChanged,
              ),
            ),
          ),
          if (isIndicator)
            CW.commonBannerIndicatorView(
                selectedIndex: selectedIndex,
                length: imageList.length,
                height: indicatorHeight,
                width: indicatorWidth,
                activeColor: indicatorActiveColor,
                inactiveColor: indicatorInactiveColor,
                bottomPadding: indicatorBottomPadding,
                animationDuration: indicatorAnimationDuration,
                cornerRadius: indicatorCornerRadius,
                space: indicatorSpace),
        ],
      );

  ///flutter pub add carousel_indicator :- For Banner Indicator
  static Widget commonBannerIndicatorView({
    required int selectedIndex,
    required int length,
    int animationDuration = 300,
    double? height,
    double? width,
    double? bottomPadding,
    double? space,
    double? cornerRadius,
    Color? activeColor,
    Color? inactiveColor,
  }) => Padding(
        padding: EdgeInsets.only(bottom: bottomPadding ?? 12.px),
        child: CarouselIndicator(
          count: length,
          index: selectedIndex,
          height: height ?? 6.px,
          color: inactiveColor ?? Col.inverseSecondary,
          width: width ?? 20.px,
          activeColor: activeColor ?? Col.primary,
          cornerRadius: cornerRadius ?? 6.px,
          space: space ?? 5.px,
          animationDuration: animationDuration,
        ),
      );

  static Widget commonPageView(
          {required NullableIndexedWidgetBuilder? itemBuilder,
          required ValueChanged<int>? onPageChanged,
          required int itemCount,
          required int selectedIndex,
          required PageController controller,
          List<String> imageList = const [],
          ScrollPhysics? physics,
          Axis axis = Axis.horizontal,
          double? imageHeight,
          EdgeInsetsGeometry? imagePadding,
          bool isIndicator = true,
          Alignment imageAlignment = Alignment.center,
          double? indicatorHeight,
          double? indicatorWidth,
          double? indicatorBottomPadding,
          double? indicatorSpace,
          double? indicatorCornerRadius,
          Color? indicatorActiveColor,
          Color? indicatorInactiveColor,
          int indicatorAnimationDuration = 300,
          Alignment indicatorAlignment = Alignment.bottomCenter,
          bool isNextButton = true,
          EdgeInsetsGeometry? buttonMargin,
          VoidCallback? onNextPressed,
          Alignment nextButtonAlignment = Alignment.topRight,
          Function? lastIndexCalling}) => Stack(
        children: [
          Align(
            alignment: imageAlignment,
            child: SizedBox(
              height: imageHeight,
              child: Padding(
                padding: imagePadding ?? EdgeInsets.zero,
                child: PageView.builder(
                  physics: physics ?? const ScrollPhysics(),
                  scrollDirection: axis,
                  scrollBehavior: ListScrollBehavior(),
                  onPageChanged: onPageChanged,
                  controller: controller,
                  itemBuilder: itemBuilder ??
                      (context, index) => CW.commonNetworkImageView(
                            path: imageList[index],
                            isAssetImage: false,
                          ),
                  itemCount: itemCount,
                ),
              ),
            ),
          ),
          if (isIndicator)
            Align(
              alignment: indicatorAlignment,
              child: CW.commonBannerIndicatorView(
                  selectedIndex: selectedIndex,
                  length: itemCount,
                  bottomPadding: indicatorBottomPadding ?? 50.px,
                  height: indicatorHeight,
                  width: indicatorWidth,
                  cornerRadius: indicatorCornerRadius,
                  space: indicatorSpace,
                  animationDuration: indicatorAnimationDuration,
                  inactiveColor: indicatorInactiveColor,
                  activeColor: indicatorActiveColor),
            ),
          if (isNextButton)
            Align(
              alignment: nextButtonAlignment,
              child: CW.commonElevatedButton(
                margin: buttonMargin ?? EdgeInsets.all(10.px),
                onPressed: onNextPressed ??
                    () {
                      if (selectedIndex == itemCount - 1) {
                        lastIndexCalling?.call();
                      } else {
                        controller.jumpToPage(selectedIndex + 1);
                      }
                    },
                child: Text(
                  C.textNext,
                  style: Theme.of(Get.context!).textTheme.displaySmall,
                ),
              ),
            )
        ],
      );

  ///flutter pub add pin_code_fields :- For Otp Text Field
  static Widget commonOtpView({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    PinCodeFieldShape shape = PinCodeFieldShape.underline,
    TextInputType keyboardType = TextInputType.number,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onCompleted,
    String? hintCharacter,
    int length = 4,
    double? height,
    double? width,
    double? borderRadius,
    double? borderWidth,
    bool readOnly = false,
    bool autoFocus = false,
    bool enableActiveFill = true,
    bool enablePinAutofill = true,
    bool autoDismissKeyboard = true,
    TextStyle? textStyle,
    Color? cursorColor,
    Color? inactiveColor,
    Color? inactiveFillColor,
    Color? activeColor,
    Color? activeFillColor,
    Color? selectedColor,
    Color? selectedFillColor,
  }) => PinCodeTextField(
        length: length,
        mainAxisAlignment: mainAxisAlignment,
        appContext: Get.context!,
        cursorColor: cursorColor ?? Col.secondary,
        autoFocus: autoFocus,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters ??
            <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        readOnly: readOnly,
        textStyle: textStyle ?? Theme.of(Get.context!).textTheme.headlineMedium,
        autoDisposeControllers: false,
        enabled: true,
        animationType: AnimationType.fade,
        hintCharacter: hintCharacter ?? "-",
        hintStyle: textStyle ?? Theme.of(Get.context!).textTheme.headlineMedium,
        scrollPadding: EdgeInsets.zero,
        pinTheme: PinTheme(
          fieldOuterPadding: EdgeInsets.zero,
          inactiveColor: inactiveColor ?? Col.gray.withOpacity(0.3),
          inactiveFillColor: inactiveFillColor ?? Col.gray.withOpacity(0.3),
          selectedColor: selectedColor ?? Col.primary,
          selectedFillColor: selectedFillColor ?? Col.inverseSecondary,
          activeColor: activeColor ?? Col.primary,
          activeFillColor: activeFillColor ?? Col.inverseSecondary,
          shape: shape,
          fieldWidth: width ?? 50.px,
          fieldHeight: height ?? 50.px,
          borderWidth: borderWidth ?? 1.px,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.px),
        ),
        enableActiveFill:
            shape == PinCodeFieldShape.box || shape == PinCodeFieldShape.circle
                ? true
                : false,
        controller: controller,
        onChanged: onChanged,
        enablePinAutofill: enablePinAutofill,
        onCompleted: onCompleted,
        autoDismissKeyboard: autoDismissKeyboard,
      );

  /// --------------------------Common Switch/Radio/Checkbox/Divider Collection--------------------------

  ///For Custom Size Use Inside SizedBox
  static Widget commonSwitchView(
          {required bool changeValue,
          required ValueChanged<bool>? onChanged,
          Color? enableDotColor,
          Color? disableDotColor,
          Color? onColor,
          Color? offColor}) =>
      cupertino.CupertinoSwitch(
        value: changeValue,
        onChanged: onChanged,
        activeColor: onColor ?? Col.primary,
        thumbColor: changeValue
            ? enableDotColor ?? Col.inverseSecondary
            : disableDotColor ?? Col.inverseSecondary,
        trackColor: offColor ?? Col.textGrayColor,
      );

  static Widget commonSwitchButtonView(
          {required bool value,
          required GestureTapCallback onChange,
          double? switchBackgroundHeight,
          double? switchBackgroundWidth,
          double? switchBackgroundBorderRadius,
          double? switchCircleHeight,
          double? switchCircleWidth,
          required Color switchBackgroundColor,
          Color? switchCircleColor}) => InkWell(
        onTap: onChange,
        borderRadius:
            BorderRadius.circular(switchBackgroundBorderRadius ?? 7.px),
        child: AnimatedContainer(
          width: switchBackgroundWidth ?? 32.px,
          height: switchBackgroundHeight ?? 14.px,
          duration: const Duration(milliseconds: 250),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(
            color: switchBackgroundColor,
            borderRadius:
                BorderRadius.circular(switchBackgroundBorderRadius ?? 7.px),
          ),
          child: AnimatedContainer(
            width: switchCircleWidth ?? 10.px,
            height: switchCircleHeight ?? 10.px,
            margin: EdgeInsets.all(2.px),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: switchCircleColor ?? Col.inverseSecondary),
            duration: const Duration(milliseconds: 250),
          ),
        ),
      );

  ///For Custom Size Use Inside SizedBox
  static Widget commonRadioView({
    required ValueChanged? onChanged,
    required String index,
    required String selectedIndex,
    Color? focusColor,
    Color? activeColor,
    VisualDensity? visualDensity
  }) => Radio(
        toggleable: true,
        visualDensity: visualDensity,
        fillColor: MaterialStateProperty.all(focusColor ?? Col.primary),
        overlayColor: MaterialStateProperty.all(focusColor ?? Col.inverseSecondary),
        focusColor: focusColor ?? Col.inverseSecondary,
        activeColor: activeColor ?? Col.primary,
        value: index,
        groupValue: selectedIndex,
        onChanged: onChanged,
        /*
         define selectedIndex in controller
         final selectIndex=Rxn<int>();
         onChanged: (flag) {
            if (controller.selectedIndex.value == index) {
              controller.selectedIndex.value = -1;
            } else {
              controller.selectedIndex.value = flag;
            }
          }*/
      );

  ///For Custom Size Use Inside SizedBox
  static Widget commonCheckBoxView({
    required bool changeValue,
    required ValueChanged<bool?>? onChanged,
    OutlinedBorder? shape,
    Color? activeFillColor,
    Color? checkColor,
    Color? borderColor,
    VisualDensity? visualDensity
  }) => Checkbox(
        visualDensity: visualDensity,
        value: changeValue,
        onChanged: onChanged,
        activeColor: activeFillColor ?? Col.primary,
        checkColor: checkColor ?? Col.inverseSecondary,
        splashRadius: 24.px,
        side: BorderSide(color: borderColor ?? Col.darkGray, width: 1.px),
        shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.px)),
      );

  static Widget commonDividerView({
    Color? color,
    double? height,
    double? wight,
    double? leftPadding,
    double? rightPadding,
  }) => Divider(
        color: color ?? Col.primary.withOpacity(.2),
        height: height ?? 10.px,
        thickness: wight ?? .5.px,
        endIndent: rightPadding,
        indent: leftPadding,
      );

  static OverlayEntry showOverlay(
      {required BuildContext context,
      required String imagePath,
      String? userShortName,
      double? height,
      double? width,
      double? borderRadius}) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Material(
          color: Col.primary.withOpacity(.2),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.px),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius ?? 68),
                child: CW.commonNetworkImageView(
                  path: imagePath,
                  isAssetImage: false,
                  height: height ?? 136.px,
                  width: width ?? 136.px,
                  errorImageValue: true,
                  userShortName: userShortName,
                  userShortNameValue: true,
                ),
              ),
            ),
          ),
        );
      },
    );

    // Insert overlay entry
    Overlay.of(context).insert(overlayEntry);
    return overlayEntry;
    // // Remove overlay entry after some time (e.g., 3 seconds)
    // Future.delayed(Duration(seconds: 3), () {
    //   // controller.overlayEntry.remove();
    // });
  }

  /// --------------------------Common ImageView/Shimmer/ReadMore/Ratting Collection--------------------------

  static Widget commonNetworkImageView(
          {required String path,
          required bool isAssetImage,
          double? height,
          double? width,
          double? radius,
          Color? color,
          BoxFit fit = BoxFit.fill,
          GestureTapCallback? onTap,
          ImageLoadingBuilder? loadingBuilder,
          Duration? shimmerDuration,
          Color? shimmerBackgroundColor,
          Color? shimmerMovementColor,
          String? errorImage,
          String? userShortName,
          Color? userShortNameColor,
          Color? userShortNameBackgroundColor,
          bool errorImageValue = false,
          bool userShortNameValue = false}) => InkWell(
           onTap: onTap,
           borderRadius: BorderRadius.circular(radius ?? 0.px),
           child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 0.px),
          child: isAssetImage
              ? Image.asset(
                  path,
                  height: height,
                  width: width,
                  color: color,
                  fit: fit,
                )
              : Image.network(
                  path,
                  height: height,
                  width: width,
                  color: color,
                  fit: fit,
                  loadingBuilder: loadingBuilder ??
                      (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CW.commonShimmerViewForImage(
                            height: height,
                            width: width,
                            radius: radius,
                            backgroundColor: shimmerBackgroundColor,
                            duration: shimmerDuration,
                            movementColor: shimmerMovementColor);
                      },
                  errorBuilder: (context, error, stackTrace) {
                    if (errorImageValue) {
                      return Container(
                        height: height,
                        width: width,
                        // margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            gradient: commonLinearGradientForButtonsView(),
                            // color: userShortNameBackgroundColor ?? Col.primary,
                            // shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.px)),
                        child: Center(
                          child: Text(
                            userShortName ?? "",
                            style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: userShortNameColor ?? Col.inverseSecondary, fontSize: userShortNameValue ? 30.px : 14.px),
                          ),
                        ),
                      );
                    } else {
                      return Image.asset(
                        errorImage ?? 'assets/images/default_image.jpg',
                        height: height,
                        width: width,
                        color: color,
                        fit: fit,
                      );
                    }
                  },
                ),
        ),
      );

  static Widget commonNoNetworkView() => Center(
        child: CW.commonNetworkImageView(path: 'assets/images/no_internet_dialog.png', isAssetImage: true),
      );

  static Widget commonShimmerViewForImage(
      {double? width,
      double? height,
      double? radius,
      Duration? duration,
      Color? backgroundColor,
      Color? movementColor}) {
    return Shimmer.fromColors(
      period: duration ?? const Duration(milliseconds: 1000),
      baseColor: backgroundColor ?? Col.primary.withOpacity(.3),
      highlightColor: movementColor ?? Col.primary.withOpacity(.02),
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Col.gray, //without this color shimmer not work
          borderRadius: BorderRadius.circular(radius ?? 5.px),
        ),
      ),
    );
  }

  static Widget commonReadMoreText({
    required String value,
    String? readMoreText,
    String? readLessText,
    int? maxLine,
    TextStyle? textStyle,
    Color? textColor,
    TextStyle? readMoreTextStyle,
    TextStyle? readLessTextStyle,
  }) {
    return ReadMoreText(
      value,
      style: textStyle ?? Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500,color: textColor ?? Col.gTextColor),
      moreStyle: readMoreTextStyle ?? Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: Col.primary, fontSize: 10.px),
      lessStyle: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: Col.primary, fontSize: 10.px),
      trimLines: maxLine ?? 3,
      trimLength: 7,
      trimCollapsedText: C.textReadMore,
      trimExpandedText: C.textReadLess,
      trimMode: TrimMode.Line,
    );
  }

  static Widget commonRattingView(
          {required double rating,
          IndexedWidgetBuilder? itemBuilder,
          double? size,
          Color? color,
          int rattingCount = 5,
          EdgeInsets itemPadding = EdgeInsets.zero,
          Axis direction = Axis.horizontal}) => RatingBarIndicator(
           rating: rating,
           itemBuilder: itemBuilder ?? (context, index) => Icon(
                     Icons.star,
                     color: color ?? Col.primary,
                   ),
           itemPadding: itemPadding,
           itemCount: rattingCount,
           itemSize: size ?? 16.px,
           direction: direction,
      );

  static Widget commonRattingBuilder({
    required double rating,
    required ValueChanged<double> onRatingUpdate,
    IndexedWidgetBuilder? itemBuilder,
    double? size,
    double minRating = 1.0,
    int rattingCount = 5,
    bool allowHalfRating = false,
    bool glow = false,
    EdgeInsets itemPadding = EdgeInsets.zero,
    Axis direction = Axis.horizontal,
    Color? color,
    Color? glowColor,
    Color? unratedColor,
  }) => RatingBar.builder(
        initialRating: rating,
        minRating: minRating,
        direction: direction,
        allowHalfRating: allowHalfRating,
        itemCount: rattingCount,
        itemPadding: itemPadding,
        glowColor: glowColor ?? Col.primary,
        unratedColor: unratedColor,
        glow: glow,
        itemBuilder: itemBuilder ?? (context, index) => Icon(
                  Icons.star,
                  color: color ?? Col.primary,
                ),
        onRatingUpdate: onRatingUpdate,
        itemSize: size ?? 16.px,
      );

  /// --------------------------Common GridView/Dower Collection--------------------------

  static Widget commonGridView(
          {required int length,
          required Widget Function(int index) child,
          required double height,
          int crossAxisCount = 2,
          EdgeInsetsGeometry? externalPadding,
          EdgeInsetsGeometry? padding,
          EdgeInsetsGeometry? margin,
          Color? backgroundColor,
          double? borderRadius,
          double? bottomMargin,
          double? topMargin,
          ScrollController? scrollController,
          VoidCallback? onTab}) => SingleChildScrollView(
        padding: externalPadding ?? EdgeInsets.only(top: C.margin, bottom: C.margin + C.margin),
        controller: scrollController,
        physics: const ScrollPhysics(),
        child: Wrap(
          children: List.generate(
              length,
              child ??
                  (index) {
                    final cellWidth =
                        MediaQuery.of(Get.context!).size.width / crossAxisCount;
                    return SizedBox(
                      width: cellWidth,
                      child: Padding(
                        padding: margin ??
                            EdgeInsets.only(
                                left: index % 2 == 0 ? C.margin : C.margin / 2,
                                right: index % 2 == 0 ? C.margin / 2 : C.margin,
                                top: topMargin ?? C.margin,
                                bottom: bottomMargin ?? 0.px),
                        child: InkWell(
                          onTap: onTab,
                          borderRadius:
                              BorderRadius.circular(borderRadius ?? 10.px),
                          child: Ink(
                              width: cellWidth,
                              height: height,
                              padding: padding ?? EdgeInsets.all(10.px),
                              decoration: BoxDecoration(
                                color: backgroundColor ?? Col.inverseSecondary,
                                borderRadius: BorderRadius.circular(
                                    borderRadius ?? 10.px),
                              ),
                              child: Container()),
                        ),
                      ),
                    );
                  }),
        ),
      );

  static commonNoDataFoundText({String? text}) => Center(
        child: commonNetworkImageView(
            path: 'assets/images/no_data_found_image.png',
            isAssetImage: true,
            height: 250.px,
            width: 250.px),
      );

  // static commonNoDataFoundText({String? text}) => Center(
  //       child:  Text(
  //     text ?? 'No Data Found!',
  //     style: Theme.of(Get.context!)
  //         .textTheme
  //         .displayLarge
  //         ?.copyWith(color: Col.primary),
  //     textAlign: TextAlign.center,
  //   ),
  //     );

  static CachedNetworkImage commonCachedNetworkImageView(
      {required String path,
      double? height,
      double? width,
      double? radius,
      BoxFit fit = BoxFit.fill,
      GestureTapCallback? onTap,
      PlaceholderWidgetBuilder? loadingBuilder,
      Duration? shimmerDuration,
      Color? shimmerBackgroundColor,
      Color? shimmerMovementColor,
      String? errorImage,
      Color? imageColor}) {
    return CachedNetworkImage(
      imageUrl: path,
      color: imageColor,
      // imageBuilder: (context, imageProvider) => Container(
      //   height: height,
      //   width: width,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(radius ?? 0.px),
      //     image: DecorationImage(
      //       image: imageProvider,
      //       fit: fit,
      //     ),
      //   ),
      // ),
      placeholder: loadingBuilder ??
          (context, url) {
            return CW.commonShimmerViewForImage(
                height: height,
                width: width,
                radius: radius,
                backgroundColor: shimmerBackgroundColor,
                duration: shimmerDuration,
                movementColor: shimmerMovementColor);
          },
      errorWidget: (context, url, error) => Image.asset(
        errorImage ?? 'assets/images/default_image.jpg',
        height: height,
        width: width,
        color: imageColor,
        fit: fit,
      ),
    );
  }

  static Widget commonCachedNetworkImageView1(
      {required String path,
      double? height,
      double? width,
      double? radius,
      BoxFit fit = BoxFit.fill,
      GestureTapCallback? onTap,
      PlaceholderWidgetBuilder? loadingBuilder,
      Duration? shimmerDuration,
      Color? shimmerBackgroundColor,
      Color? shimmerMovementColor,
      String? errorImage,
      Color? imageColor,
      bool apiResValue = false}) {
    return CachedNetworkImage(
      imageUrl: path,
      fadeInDuration: const Duration(microseconds: 0),
      fadeOutDuration: const Duration(microseconds: 0),
      imageBuilder: (context, imageProvider) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 0),
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
      ),
      placeholder: loadingBuilder ??
          (context, url) {
            return commonShimmerViewForImage(
              height: height,
              width: width,
              radius: radius,
              backgroundColor: shimmerBackgroundColor,
              duration: shimmerDuration,
              movementColor: shimmerMovementColor,
            );
          },
      errorWidget: (context, url, error) => Image.asset(
        errorImage ?? 'assets/images/default_image.jpg',
        height: height,
        width: width,
        color: imageColor,
        fit: fit,
      ),
    );
  }

}

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Color activeColor;
  final Color? fillColor;

  CustomRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.activeColor,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: groupValue == value ? Col.primary : activeColor,
              width: 2.px),
        ),
        child: Padding(
          padding: EdgeInsets.all(2.px),
          child: groupValue == value
              ? Container(
                  width: 8.px,
                  height: 8.px,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Col.primary,
                  ),
                )
              : SizedBox(
                  height: 8.px,
                  width: 8.px,
                ),
        ),
      ),
    );
  }
}
