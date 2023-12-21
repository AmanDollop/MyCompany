import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:location/location.dart';
import 'package:open_apps_settings/open_apps_settings.dart';
import 'package:open_apps_settings/settings_enum.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/my_http/status_code_constant.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/constants/constants.dart';
import 'package:http/http.dart' as http;

class CM {
  ///  flutter pub add internet_connection_checker -- For Check Internet
  static Future<bool> internetConnectionCheckerMethod() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  ///  flutter pub add fluttertoast --For Show Toast
  static void showToast(
    String msg, {
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: gravity ?? ToastGravity.BOTTOM,
    );
  }

  /// FOR UN_FOCUS KEYBOARD
  static void unFocusKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// FOR GET DEVICE TYPE
  static String getDeviceType() {
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "IOS";
    } else {
      return "";
    }
  }

  ///FOR SHOW SNACKBAR required flutter pub add responsive_sizer
  static void showSnackBar(
      {required String message,
      Duration? duration,
      bool isFloating = true,
      Color? backgroundColor,
      bool showCloseIcon = false}) {
    backgroundColor = Col.primary;
    if (isFloating) {
      var snackBar = SnackBar(
        elevation: .4,
        showCloseIcon: showCloseIcon,
        closeIconColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(C.radius)),
        content: Text(
          message,
          style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                fontSize: 14.px,
              ),
        ),
        backgroundColor: backgroundColor,
        margin: EdgeInsets.symmetric(horizontal: C.margin, vertical: C.margin),
        behavior: SnackBarBehavior.floating,
        duration: duration ?? const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    } else {
      var snackBar = SnackBar(
        elevation: .4,
        showCloseIcon: showCloseIcon,
        closeIconColor: Colors.white,
        content: Text(
          message,
          style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                fontSize: 14.px,
              ),
        ),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  static void error() {
    showSnackBar(message: 'Something went wrong');
  }

  static void noInternet() {
    showSnackBar(message: 'Please check your internet connection');
  }

  ///flutter pub add shared_preferences --For Local DataBase
  static Future<String?> getString({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  ///flutter pub add shared_preferences --For Local DataBase
  static Future<bool> setString(
      {required String key, required String value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value);
  }

  ///flutter pub add intl --FOR DateFormat
  static String dateTimeToAgo(String dateTime) {
    DateTime input = DateTime.parse(dateTime);
    Duration diff = DateTime.now().difference(input);
    if (diff.inDays >= 1) {
      return diff.inDays < 7
          ? '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago'
          : DateFormat('MMM d').format(input);
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }

  static Future<void> setScreenMode(
      {DeviceOrientation? deviceOrientation}) async {
    await SystemChrome.setPreferredOrientations([
      deviceOrientation ?? DeviceOrientation.portraitUp,
    ]);
  }

  ///For Get Device Size Expect Tool Bar Or Bottom
  static double getDeviceSize() {
    double availableHeight = MediaQuery.of(Get.context!).size.height -
        MediaQuery.of(Get.context!).padding.top -
        MediaQuery.of(Get.context!).padding.bottom;
    return availableHeight;
  }

  ///For Get Device Size Expect Tool Bar Or Bottom
  static double getDeviceSizeWithoutAppBar() {
    double availableHeight = MediaQuery.of(Get.context!).size.height -
        MediaQuery.of(Get.context!).padding.bottom -
        getAppBarSize();
    return availableHeight;
  }

  ///For Get App Bar Size
  static double getAppBarSize() {
    return AppBar().preferredSize.height;
  }

  ///For Get Tool Bar Size
  static double getToolBarSize() {
    return MediaQuery.of(Get.context!).padding.top;
  }

  ///For Get Six Digit Random Number
  static String getRandomNumber() {
    var random = Random();
    int min = 100000;
    int max = 999999;
    var number = min + random.nextInt(max - min);
    return number.toString();
  }

  ///flutter pub add device_info_plus For Get Device Id
  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // UNIQUE ID ON iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // UNIQUE ID ON ANDROID
    }
    return null;
  }

  ///For Convert Color into Material Color
  static MaterialColor getMaterialColor({required Color color}) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

  ///For Insert Data In DataBase
  /*  static Future<bool> insertDataIntoDataBase({UserData? userData}) async {
    DatabaseHelper.db = await DatabaseHelper.databaseHelperInstance.openDB();
    if (await DatabaseHelper.databaseHelperInstance.isDatabaseEmpty()) {
      bool isInsert = await DatabaseHelper.databaseHelperInstance.insert(
        data: CM.insertDataInModel(userData: userData),
      );
      return isInsert;
    } else {
      await DatabaseHelper.databaseHelperInstance.update(
          data: CM.insertDataInModel(userData: userData));
      return true;
    }
  }*/

  static Future<GetLatLong?> getUserLatLong({required BuildContext context}) async {
    if (await CM.internetConnectionCheckerMethod()) {
      Location location = Location();
      bool serviceEnabled;
      PermissionStatus permissionGranted;
      serviceEnabled = await location.serviceEnabled();
      print('serviceEnabled::::::   $serviceEnabled');

      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }
      permissionGranted = await location.hasPermission();
      print('permissionGranted::::::   $permissionGranted');

      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted == PermissionStatus.denied) {
          return null;
        } else if (permissionGranted == PermissionStatus.deniedForever) {
          await OpenAppsSettings.openAppsSettings(
              settingsCode: SettingsCode.APP_SETTINGS);
          permissionGranted = await location.hasPermission();
          if (permissionGranted == PermissionStatus.denied) {
            return null;
          } else if (permissionGranted == PermissionStatus.deniedForever) {
            return null;
          } else if (permissionGranted == PermissionStatus.granted) {
            return await getLatLong();
          }
        } else if (permissionGranted == PermissionStatus.granted) {
          return await getLatLong();
        }
      }
      else if (permissionGranted == PermissionStatus.granted) {
        return await getLatLong();
      }
    }
    else {
      CM.showSnackBar(message: 'Check Your Internet Connection');
      return null;
    }
    return null;
  }

  static Future<GetLatLong?> getLatLong() async {
    LocationData? myLocation;
    Location location = Location();

    /*try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {}
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {}

      return null;
    }*/
    print('location   ::::::   $location');
    myLocation = await location.getLocation();
    print('myLocation.latitude:::::::::    ${myLocation.latitude}');

    if (myLocation.latitude != null && myLocation.longitude != null) {

      GetLatLong getLatLongData = GetLatLong(latitude:myLocation.latitude,longitude: myLocation.longitude );


      return getLatLongData;
    } else {
      return null;
    }
  }

  static Future<bool> checkResponse({required http.Response response, bool wantShowSuccessResponse = false, bool wantShowFailResponse = false, bool wantInternetFailResponse = false}) async {
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    if (await CM.internetConnectionCheckerMethod()) {
      if (response.statusCode == StatusCodeConstant.OK) {
        if (wantShowSuccessResponse) {
          CM.showSnackBar(message: responseMap[AK.message]);
        }
        return true;
      } else if (response.statusCode == StatusCodeConstant.BAD_REQUEST) {
        if (wantShowFailResponse) {
          CM.showSnackBar(message: responseMap[AK.message]);
        }
        return false;
      } else if (response.statusCode == StatusCodeConstant.BAD_GATEWAY) {
        return false;
      } else if (response.statusCode == StatusCodeConstant.REQUEST_TIMEOUT) {
        return false;
      } else {
        return false;
      }
    } else {

      return false;
    }
  }

}

class GetLatLong{
  double? latitude;
  double? longitude;

  GetLatLong({ double? latitude, double? longitude})
  {
    this.latitude=latitude;
    this.longitude=longitude;
  }


}