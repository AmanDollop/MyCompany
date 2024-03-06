import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:task/main.dart';
import '../../common_methods/cm.dart';
import 'package:http/http.dart' as http;

/*
Base Url         :- https://fcm.googleapis.com/fcm/send
Method Type      :- POST
Row Data For Api :-
{
  "to": "userToken",
  "data": {
    "title": "Your Notification Title",
    "body": "Your Notification Body"
  }
}
Headers          :-
Authorization:key=Server Key,
Content-Type:application/json

 */

class NS {
  ///For Give Permission Add:- flutter pub add permission_handler
  static Future<bool> getPermission({Permission permission = Permission.storage}) async {
    PermissionStatus status = await permission.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.denied) {
      return false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
      status = await permission.status;
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings(
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentSound: true,
  );

  final DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails(
    subtitle: "This channel is responsible for all the local notifications",
    sound: 'Notification',
  );

  Future<bool> requestNotificationPermission() async {
    return await getPermission(permission: Permission.notification);
  }

  Future<void> initNotification() async {
    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onSelectNotification, onDidReceiveBackgroundNotificationResponse: onSelectNotification);

    await initFirebaseNotification();
  }

  Future<void> initFirebaseNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print("NOTIFICATION TITLE:::::::${message.notification?.title}");
        print("NOTIFICATION BODY::::::::${message.notification?.body}");
        print("NOTIFICATION DATA::::::::${message.data}");
      }
      showNotification(remoteMessage: message);
    });

    /*   FirebaseMessaging.onMessageOpenedApp.listen((notificationResponse) {
      if (!kDebugMode) {
        print("CLICK ON NOTIFICATION ON MESSAGE OPEN:::::::::::::${notificationResponse.data}");
      }
    });
*/

    /* FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (!kDebugMode) {
        print("CLICK ON NOTIFICATION GET INITIAL MESSAGE:::::");
        print("CLICK ON NOTIFICATION TITLE :::::::${message?.notification?.title}");
        print("CLICK ON NOTIFICATION TITLE :::::::${message?.notification?.body}");
        print("CLICK ON NOTIFICATION TITLE :::::::${message?.data}");
      }
    });*/
  }

  Future<void> showNotification({
    required RemoteMessage remoteMessage,
    String? payload,
  }) async {

    await initNotification();
    AndroidNotificationDetails androidNotificationDetails;
    print('remoteMessage.data:::: ${remoteMessage.data}');
    print('remoteMessage.data["title"]::::: ${remoteMessage.data["title"]}');
    if (remoteMessage.data["image"] != null && remoteMessage.data["image"] != '') {
      final http.Response response = await http.get(Uri.parse('${remoteMessage.data["image"]}'));
      Uint8List imageData = response.bodyBytes;
      androidNotificationDetails  = AndroidNotificationDetails(
        CM.getRandomNumber(),
        'Test Channel',
        channelDescription: "This channel is responsible for all the local notifications",
        playSound: true,
        priority: Priority.high,
        importance: Importance.high,
        ticker: 'ticker',
        largeIcon: ByteArrayAndroidBitmap(imageData),
        styleInformation: const BigTextStyleInformation(''),
      );
    }
    else{
      androidNotificationDetails  = AndroidNotificationDetails(
        CM.getRandomNumber(),
        'Test Channel',
        channelDescription: "This channel is responsible for all the local notifications",
        playSound: true,
        priority: Priority.high,
        importance: Importance.high,
        ticker: 'ticker',
        styleInformation: const BigTextStyleInformation(''),
      );
    }
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
    if(remoteMessage.data["title"] == 'Logout'){
      // await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForCompanyDetail);
      await BottomSheetForOTP.callingUpdateFcmIdApi(forLogOutFcmId: true);
      await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForUserDetail);
      await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForProfileMenu);
      await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForShiftDetail);
      await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForAppMenu);
      await CM.setString(key: AK.baseUrl, value: '');
      Get.offAllNamed(Routes.SEARCH_COMPANY);
    }
    else{
      await flutterLocalNotificationsPlugin.show(
        0,
        remoteMessage.data["title"],
        remoteMessage.data['body'],
        notificationDetails,
        payload: payload,
      );
    }
  }
  
}
