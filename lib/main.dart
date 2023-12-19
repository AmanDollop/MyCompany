import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_packages/scroll_behavior/scroll_behavior.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:task/theme/theme_data/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late StreamSubscription streamSubscription;
  AC().getNetworkConnectionType();
  streamSubscription = AC().checkNetworkConnection();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => ResponsiveSizer(
          builder: (
            buildContext,
            orientation,
            screenType,
          ) =>
              GetMaterialApp(
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: AppThemeData.themeData(fontFamily: C.fontKumbhSans),
            defaultTransition: Transition.rightToLeftWithFade,
            debugShowCheckedModeBanner: false,

            scrollBehavior: ListScrollBehavior(),
          ),
        ),
      ),
    );
  });
}
