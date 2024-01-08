import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/custom_outlinebutton/cub.dart';
import 'package:task/common/common_packages/rating/rating_bar.dart';
import 'package:task/common/common_packages/read_more/read_more.dart';
import 'package:task/common/common_packages/scroll_behavior/scroll_behavior.dart';
import 'package:task/common/common_packages/shimmer/shimmer.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common_packages/rating/rating_bar_indicator.dart';

class CW {
  /// --------------------------Common Button(Elevated,Outline,Text,IconButton) Collection-----------------------

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
                height: progressBarHeight??24.px,
                width: progressBarWidth??24.px,
                child: CW.commonProgressBarView(color: Col.primary),
              ),
            )
          : child ?? Text(
                buttonText ?? '',
                style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 14.px,color: buttonTextColor),
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
                minimumSize: Size(width??56.px, height??56.px)),
            child: child ??
                Text(
                  buttonText ?? '',
                  style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: buttonTextColor
                      ),
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
  static LinearGradient commonLinearGradientView() => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFBAD33),
          Color(0xFFF2653A),
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

  static Widget commonLinearProgressBar({required double value, double? height}) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(20.px),
        child: LinearProgressIndicator(
          color: Col.primary,
          backgroundColor: Col.gray,
          value: value,
          minHeight: height ?? 10.px,
        ),
      );

  static commonProgressBarView({Color? color,Color? backgroundColor,double? value}) => CircularProgressIndicator(
        backgroundColor: color ?? Col.gray,
        color:backgroundColor?? Col.inverseSecondary,
        value: value,
        strokeWidth: 3,
      );

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
      bool readOnly = false,
      bool filled = true,
      bool isUnderlineBorder = false,
      bool isHideText = false,
      bool isCountrySelection = false,
      VoidCallback? clickOnArrowDown,
      String selectedCountryCode = "",
      String countryFlagPath = "", int? maxLength}) {
    return Theme(
      data: ThemeData(

      ),
      child: TextFormField(
        cursorHeight: cursorHeight,
        onTap: onTap,
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
        style: style ?? Theme.of(Get.context!).textTheme.titleLarge,
        maxLength: maxLength,
        decoration: isUnderlineBorder
            ? InputDecoration(
                labelText: labelText,
                errorStyle: errorStyle ?? Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.error),
                labelStyle: labelStyle ?? Theme.of(Get.context!).textTheme.bodyMedium,
                hintText: hintText,
                fillColor: fillColor ?? Col.inverseSecondary,
                filled: filled ? true : false,
                contentPadding: contentPadding ?? EdgeInsets.only(left: 8.px, right: 8.px, top: 3.px),
                hintStyle: hintStyle ?? Theme.of(Get.context!).textTheme.bodyMedium,
                disabledBorder: UnderlineInputBorder(
                    borderSide: isBorder
                        ? BorderSide(color: Col.inverseSecondary, width: 1.px)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
                border: UnderlineInputBorder(
                    borderSide: isBorder
                        ? BorderSide(color: Col.primary, width: 1.px)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: isBorder
                        ? BorderSide(
                            color: filled ? initialBorderColor ?? Col.inverseSecondary : Col.secondary,
                            width: initialBorderWidth ?? 1.px)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
                errorBorder: UnderlineInputBorder(
                  borderSide: isBorder
                      ? BorderSide(color: Col.error, width: 1.px)
                      : BorderSide.none,
                  borderRadius:
                      BorderRadius.circular(borderRadius ?? C.textFieldRadius),
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
                labelStyle: labelStyle ?? Theme.of(Get.context!).textTheme.titleMedium,
                errorStyle: errorStyle ?? Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.error),
                hintText: hintText,
                fillColor: fillColor ?? Col.inverseSecondary,
                filled: filled,
                contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.px),
                hintStyle: hintStyle ?? Theme.of(Get.context!).textTheme.titleMedium,
                disabledBorder: OutlineInputBorder(
                    borderSide: isBorder
                        ? BorderSide(color: Col.gray, width: 1.px)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
                border: OutlineInputBorder(
                    borderSide: isBorder
                        ? BorderSide(color: Col.primary, width: 1.px)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
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
                    borderRadius:
                        BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
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
                                      Icon(Icons.arrow_drop_down,size: 26.px,color: Col.gray),
                                      Center(
                                        child: CW.commonNetworkImageView(
                                            path: countryFlagPath,
                                            isAssetImage: false,
                                            height: 14.px,
                                            width: 20.px),
                                      ),
                                      SizedBox(width: 4.px),
                                      Text(selectedCountryCode,style: Theme.of(Get.context!).textTheme.titleSmall),
                                      SizedBox(width: 6.px),
                                      VerticalDivider(
                                        width: 2,
                                        indent: 10.px,
                                        endIndent: 10.px,
                                        color: Col.secondary,
                                        thickness: 1.px,
                                      ),
                                      SizedBox(width: 10.px),
                                    ],
                                  ),
                                ),
                              )
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
                                  Text(selectedCountryCode, style: Theme.of(Get.context!).textTheme.titleSmall),
                                  SizedBox(width: 4.px),
                                  Icon(Icons.keyboard_arrow_down, size: 20.px, color: Col.secondary),
                                  SizedBox(width: 4.px),
                                  VerticalDivider(
                                    width: 2,
                                    indent: 10.px,
                                    endIndent: 10.px,
                                    color: Col.secondary,
                                    thickness: 2.px,
                                  ),
                                  SizedBox(width: 10.px),
                                ],
                              ),
                            ),
                          )
                        : null,
              ),
      ),
    );
  }

  static Widget commonTextFieldForMultiline({
    String? hintText,
    TextStyle? hintStyle,
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
    double? elevation,
    bool isBorder = true,
    bool autofocus = false,
    bool readOnly = false,
    bool filled = true,
    TextInputAction? textInputAction,
  }) {
    return Theme(
      data: ThemeData(),
      child: SizedBox(
        height: maxHeight,
        child: Card(
          elevation: elevation ?? 0.px,
          color: Col.inverseSecondary,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius),
              borderSide: BorderSide.none),
          child: TextFormField(
            textInputAction: textInputAction,
            cursorHeight: cursorHeight,
            controller: controller,
            maxLines: maxLines,
            validator: validator,
            keyboardType: keyboardType,
            readOnly: readOnly,
            autofocus: autofocus,
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization,
            style: style ?? Theme.of(Get.context!).textTheme.titleLarge,
            decoration: InputDecoration(
              labelText: labelText,
                labelStyle: labelStyle ?? Theme.of(Get.context!).textTheme.bodyMedium,
              errorStyle: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.error),
              hintText: hintText,
              fillColor: fillColor ?? Col.inverseSecondary,
              filled: filled,
              contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.px,vertical: 10.px),
                hintStyle: hintStyle ?? Theme.of(Get.context!).textTheme.bodyMedium,
              disabledBorder: OutlineInputBorder(
                  borderSide: isBorder
                      ? BorderSide(color: Col.gray, width: 1.px)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
              border: OutlineInputBorder(
                  borderSide: isBorder
                      ? BorderSide(color: Col.primary, width: 1.px)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
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
                  borderRadius:
                  BorderRadius.circular(borderRadius ?? C.textFieldRadius)),
              suffixIcon: suffixIcon != null
                  ? Padding(
                padding: suffixPadding ?? EdgeInsets.zero,
                child: suffixIcon,
              )
                  : null,
                prefixIcon: prefixIcon
            ),
          ),
        ),
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
                    style: titleStyle ?? Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 16.px),
                  ),
                ],
              ),
              bottom: tabBar,
              elevation: elevation,
              centerTitle: centerTitle,
              leading: leading,
              actions: actions ?? [
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
                style: titleStyle ?? Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 16.px),
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
                          child: leading ?? IconButton(
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
              flexibleSpace: Container(
                  height: CM.getToolBarSize(),
                  color: toolBarColor ?? backgroundColor ?? Col.primary),
              titleSpacing:
                  leading != null ? titleSpacing ?? 0.px : titleSpacing,
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
          unselectedLabelStyle:
              unLabelStyle ?? Theme.of(context).textTheme.titleSmall,
          selectedLabelStyle: seLabelStyle ??
              Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Col.primary),
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
  }) =>
      TabBar(
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
  }) =>
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.px),
            child: CarouselSlider(
              items: imageList.isNotEmpty
                  ? imageList.map((image) {
                      return Padding(
                        padding: padding ?? EdgeInsets.symmetric(horizontal: C.outlineButtonRadius),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.px),
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
          Function? lastIndexCalling}) =>
      Stack(
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
        inputFormatters: inputFormatters ?? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
        enableActiveFill: shape == PinCodeFieldShape.box || shape == PinCodeFieldShape.circle ? true : false,
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

  ///For Custom Size Use Inside SizedBox
  static Widget commonRadioView({
    required ValueChanged? onChanged,
    required String index,
    required String selectedIndex,
    Color? radioColor,
  }) => Radio(
        toggleable: true,
        // fillColor: MaterialStateProperty.all(radioColor ?? Col.primary),
        focusColor: Col.gray,
        activeColor: Col.primary,
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
  }) => Checkbox(
        value: changeValue,
        onChanged: onChanged,
        activeColor: activeFillColor ?? Col.primary,
        checkColor: checkColor ?? Col.inverseSecondary,
        splashRadius: 24.px,
        side: BorderSide(color: borderColor ?? Col.darkGray, width: 2.px),
        shape: shape,
      );

  static Widget commonDividerView({
    Color? color,
    double? height,
    double? wight,
    double? leftPadding,
    double? rightPadding,
  }) => Divider(
        color: color ?? Col.gray,
        height: height ?? 10.px,
        thickness: wight ?? .5.px,
        endIndent: rightPadding,
        indent: leftPadding,
      );

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
          Color? shimmerMovementColor,String? errorImage}) => InkWell(
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
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    errorImage ?? 'assets/images/default_image.jpg',
                    height: height,
                    width: width,
                    color: color,
                    fit: fit,
                  ),
                ),
        ),
      );

  static Widget commonShimmerViewForImage(
      {double? width,
      double? height,
      double? radius,
      Duration? duration,
      Color? backgroundColor,
      Color? movementColor}) {
    return Shimmer.fromColors(
      period: duration ?? const Duration(milliseconds: 2000),
      baseColor: backgroundColor ?? Col.secondary,
      highlightColor: movementColor ?? Col.gray,
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
    TextStyle? readMoreTextStyle,
    TextStyle? readLessTextStyle,
  }) {
    return ReadMoreText(
      value,
      style: textStyle ?? Theme.of(Get.context!).textTheme.titleSmall,
      moreStyle: readMoreTextStyle ??
          Theme.of(Get.context!)
              .textTheme
              .headlineLarge
              ?.copyWith(fontSize: 14.px),
      lessStyle: readLessTextStyle ??
          Theme.of(Get.context!)
              .textTheme
              .headlineLarge
              ?.copyWith(fontSize: 14.px),
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
        itemBuilder: itemBuilder ??
            (context, index) => Icon(
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
    bool allowHalfRating = true,
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
        itemBuilder: itemBuilder ??
            (context, index) => Icon(
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
              child ?? (index) {
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
        child: Text(
          text ?? 'No Data Found!',
          style: Theme.of(Get.context!)
              .textTheme
              .displayLarge
              ?.copyWith(color: Col.primary),
          textAlign: TextAlign.center,
        ),
      );

}
