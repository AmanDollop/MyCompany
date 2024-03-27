// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_packages/notification_services/notification_services.dart';
import 'package:task/common/common_packages/scroll_behavior/scroll_behavior.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/my_drop_down/my_drop_down.dart';
import 'package:task/firebase_options.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:task/theme/theme_data/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
    );

  //FOR INITIALIZE NOTIFICATION NOTIFICATION
  NS().initNotification();
  FirebaseMessaging.onBackgroundMessage(_backgroundNotificationHandler);

  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );

  late StreamSubscription streamSubscription;

  AC().getNetworkConnectionType();
  streamSubscription = AC().checkNetworkConnection();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => ResponsiveSizer(
          builder: (buildContext, orientation, screenType) => GestureDetector(
                onTap: () async {
                  await Fluttertoast.cancel();
                },
                child: GetMaterialApp(
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
      ),
    );
  });
}


//FOR HANDLE BACKGROUND NOTIFICATION
@pragma('vm:entry-point')
Future<void> _backgroundNotificationHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NS().showNotification(remoteMessage: message);
    print("BACKGROUND NOTIFICATION TITLE::::::${message.notification?.title}");
    print("BACKGROUND NOTIFICATION BODY:::::::${message.notification?.body}");
    print("BACKGROUND NOTIFICATION DATA:::::${message.data}");
}

//FOR HANDLE CLICK ON NOTIFICATION
void onSelectNotification( {NotificationResponse? notificationResponse,required RemoteMessage message}) async {
  // print("CLICK ON NOTIFICATION ON SELECT NOTIFICATION:::::::::::::${notificationResponse?.payload}");
  // print("CLICK ON NOTIFICATION ON SELECT NOTIFICATION::::::MESSAGE:::::::${message.data}");
  // print("CLICK ON NOTIFICATION ON SELECT NOTIFICATION::::::MESSAGE[title]:::::::${message.data["title"]}");
  // print("CLICK ON NOTIFICATION ON SELECT NOTIFICATION::::::MESSAGE[body]:::::::${message.data["body"]}");
  // print("CLICK ON NOTIFICATION ON SELECT NOTIFICATION::::::MESSAGE[click_action]:::::::${message.data["click_action"]}");
  print("CLICK ON NOTIFICATION ON SELECT NOTIFICATION::::::MESSAGE[click_json]:::::::${message.data["click_json"]}");
  Map<String, dynamic> parsedJson = jsonDecode(message.data["click_json"]);
  print("CLICK ON NOTIFICATION ON SELECT NOTIFICATION::::::parsedJson   task_category_id:::::::${parsedJson['task_category_id']}");
  print("CLICK ON NOTIFICATION ON SELECT NOTIFICATION::::::parsedJson    ['task_category_name']:::::::${parsedJson['task_category_name']}");
  if(message.data["click_action"] == 'task'){
    Get.toNamed(Routes.SUB_TASK,arguments: [parsedJson['task_category_id'], parsedJson['task_category_name']]);
  }
}