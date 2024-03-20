import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class MyHttp {
  static Future<http.Response?> getMethod(
      {required String url,
      Map<String, String>? token,
      required BuildContext context}) async {
    if (kDebugMode) print("CALLING:: $url");
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.get(
          Uri.parse(url),
          headers: token,
        );
        if (kDebugMode) print("CALLING:: ${response.body}");
        //MyLogger.logger.w("CALLING:: ${response.body}");
        return response;
      } catch (e) {
         if (kDebugMode) print("CALLING:: Server Down");
       // MyLogger.logger.e("CALLING:: Server Down");
        //MyCommonMethods.serverDownShowSnackBar(context: context);
        return null;
      }
    } else {
      // CM.noInternet();
      return null;
    }
  }

  static Future<http.Response?> postMethod(
      {required String url,
      required Object bodyParams,
          Map<String, String>? token,
      required BuildContext context,bool showSnackBar = true}) async {
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.post(Uri.parse(url), body: bodyParams, headers: token,);
        print('headers::token::::  $token');
        if (kDebugMode) print("CALLING:: ${response.body}");
        if(showSnackBar) {
          Map<String,dynamic> mapRes = {};
          mapRes = jsonDecode(response.body);
          print('mapRes:::  ${mapRes}');
          CM.showSnackBar(message: mapRes['message']);
        }
        print('response.statusCode::::  ${response.statusCode}');
        if(response.statusCode == 401){
          await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForUserDetail);
          await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForProfileMenu);
          await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForShiftDetail);
          await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForAppMenu);
          await CM.setString(key: AK.baseUrl, value: '');
          Get.offAllNamed(Routes.SEARCH_COMPANY);
        }
        return response;
      } catch (e) {
        if (kDebugMode) print("ERROR:: $e");
         if (kDebugMode) print("CALLING:: Server Down");
       // MyLogger.logger.e("CALLING:: Server Down");
        //MyCommonMethods.serverDownShowSnackBar(context: context);
        return null;
      }
    } else {
      // CM.noInternet();
      return null;
    }
  }



  static Future<http.Response?> multipartRequest(
      {File? image,
      required String url,
      required String multipartRequestType /* POST or GET */,
      required Map<String, dynamic> bodyParams,
      required String token,
      required String userProfileImageKey,
      required BuildContext context}) async {
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    if (kDebugMode) print("image:: $image");
    if (kDebugMode) print("userProfileImageKey:: $userProfileImageKey");
    http.Response? res;
    if (await CM.internetConnectionCheckerMethod()) {
      if (image != null) {
        try {
          http.MultipartRequest multipartRequest = http.MultipartRequest(multipartRequestType, Uri.parse(url));
          bodyParams.forEach((key, value) {
            multipartRequest.fields[key] = value;
          });
          multipartRequest.headers['Authorization'] = token;
          multipartRequest.files.add(getUserProfileImageFile(image: image, userProfileImageKey: userProfileImageKey));
          http.StreamedResponse response = await multipartRequest.send();
          res = await http.Response.fromStream(response);

        } catch (e) {
          if (kDebugMode) print("ERROR:: $e");
           if (kDebugMode) print("CALLING:: Server Down");
        // MyLogger.logger.e("CALLING:: Server Down");
          //MyCommonMethods.serverDownShowSnackBar(context: context);
          return null;
        }
        // ignore: unnecessary_null_comparison
        if (res != null) {
          if (kDebugMode) print("CALLING:: ${res.body}");
          if(res.statusCode == 401){
            await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForUserDetail);
            await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForProfileMenu);
            await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForShiftDetail);
            await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForAppMenu);
            await CM.setString(key: AK.baseUrl, value: '');
            Get.offAllNamed(Routes.SEARCH_COMPANY);
          }
          return res;
        } else {
          return null;
        }
      } else {
        try {
          res = await http.post(
            Uri.parse(url),
            body: bodyParams,
            headers: {"authorization": token},
          );
        } catch (e) {
          if (kDebugMode) print("ERROR:: $e");
           if (kDebugMode) print("CALLING:: Server Down");
        // MyLogger.logger.e("CALLING:: Server Down");
          //MyCommonMethods.serverDownShowSnackBar(context: context);
          return null;
        }
        // ignore: unnecessary_null_comparison
        if (res != null) {
          if (kDebugMode) print("CALLING:: ${res.body}");
          return res;
        } else {
          return null;
        }
      }
    } else {
            // CM.noInternet();
      // MyLogger.logger.i("MJGRy8rfgugudgufguydgyudughdsughidhghegug");
      return null;
    }
  }

  static http.MultipartFile getUserProfileImageFile(
      {File? image, required String userProfileImageKey}) {
    return http.MultipartFile.fromBytes(
      userProfileImageKey,
      image!.readAsBytesSync(),
      filename: image.uri.pathSegments.last,
    );
  }

  static Future<http.Response?> getMethodForParams(
      {Map<String, String>? authorization,
      required Map<String, dynamic> queryParameters,
      required String baseUri,
      required String endPointUri,
      required BuildContext context}) async {
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        Uri uri = Uri.http(baseUri, endPointUri, queryParameters);
        if (kDebugMode) print("CALLING:: $uri");
        if (kDebugMode) print("queryParameters:: $queryParameters");
        http.Response? response = await http.get(uri, headers: authorization);
        if (kDebugMode) print("CALLING:: ${response.body}");
          // ignore: unnecessary_null_comparison
        if (response != null) {
          return response;
        } else {
          return null;
        }
      } catch (e) {
        if (kDebugMode) print("ERROR:: $e");
         if (kDebugMode) print("CALLING:: Server Down");
        // MyLogger.logger.e("CALLING:: Server Down");
        //MyCommonMethods.serverDownShowSnackBar(context: context);
        return null;
      }
    } else {
      // CM.noInternet();
      return null;
    }
  }

  static Future<http.Response?> multipartRequestForSignUp(
      {required Map<String, File> imageMap,
      required String url,
      required String multipartRequestType, // POST or GET
      required Map<String, dynamic> bodyParams,
      required BuildContext context}) async {
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    if (kDebugMode) print("imageMap:: $imageMap");
    http.Response? res;
    if (await CM.internetConnectionCheckerMethod()) {
      if (imageMap.isNotEmpty) {
        try {
          http.MultipartRequest multipartRequest =
              http.MultipartRequest(multipartRequestType, Uri.parse(url));
          bodyParams.forEach((key, value) {
            multipartRequest.fields[key] = value;
            if (kDebugMode) print("key::::::            $key          value::::::          $value");
          });
          imageMap.forEach((key, value) {
            multipartRequest.files.add(getUserProfileImageFile(image: value, userProfileImageKey: key));
          });
          if (kDebugMode) print("multipartRequest:: ${multipartRequest.files}");
          http.StreamedResponse response = await multipartRequest.send();
          res = await http.Response.fromStream(response);
        } catch (e) {
          if (kDebugMode) print("ERROR:: $e");
          // ignore: use_build_context_synchronously
           if (kDebugMode) print("CALLING:: Server Down");
        // MyLogger.logger.e("CALLING:: Server Down");
          //MyCommonMethods.serverDownShowSnackBar(context: context);
          return null;
        }
        // ignore: unnecessary_null_comparison
        if (res != null) {
          if (kDebugMode) print("CALLING:: ${res.body}");
          Map<String,dynamic> mapRes = {};
          mapRes = jsonDecode(res.body);
          CM.showSnackBar(message: mapRes['message']);
          if(res.statusCode == 401){
            await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForUserDetail);
            await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForProfileMenu);
            await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForShiftDetail);
            await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForAppMenu);
            await CM.setString(key: AK.baseUrl, value: '');
            Get.offAllNamed(Routes.SEARCH_COMPANY);
          }
          return res;
        } else {
          return null;
        }
      } else {
        try {
          res = await http.post(
            Uri.parse(url),
            body: bodyParams,
          );
        } catch (e) {
          if (kDebugMode) print("ERROR:: $e");
          // ignore: use_build_context_synchronously
           if (kDebugMode) print("CALLING:: Server Down");
        // MyLogger.logger.e("CALLING:: Server Down");
          //MyCommonMethods.serverDownShowSnackBar(context: context);
          return null;
        }
        // ignore: unnecessary_null_comparison
        if (res != null) {
          if (kDebugMode) print("CALLING:: ${res.body}");
          return res;
        } else {
          return null;
        }
      }
    } else {
      // ignore: use_build_context_synchronously
      // CM.noInternet();
      return null;
    }
  }

  static Future<http.Response?> uploadMultipleImagesWithBody(
      {required List<File> images,
      Map<String, File>? imageMap,
      required String uri,
      String? token,
      required String imageKey,
      required String multipartRequestType, // POST or GET
      required Map<String, dynamic> bodyParams,
      required BuildContext context}) async {
    if (await CM.internetConnectionCheckerMethod()) {
        try {
          http.Response res;
          var request = http.MultipartRequest(multipartRequestType, Uri.parse(uri));
          request.headers.addAll({'Content-Type': 'multipart/form-data'});
          if (kDebugMode) print("CALLING:: $uri");
          if(imageMap!=null)
            {
              imageMap.forEach((key, value) {
                request.files.add(getUserProfileImageFile(image: value, userProfileImageKey: key));
              });
            }
          for (int i = 0; i < images.length; i++) {
            var stream = http.ByteStream(images[i].openRead());
            var length = await images[i].length();
            var multipartFile = http.MultipartFile(imageKey, stream, length, filename: images[i].path);
            request.files.add(multipartFile);
          }
          print('token::::token::::: $token');
          print('imageKey::::imageKey::::: $imageKey');
          print('bodyParams::::keys::::: ${bodyParams.keys}');
          print('bodyParams::::values::::: ${bodyParams.values}');
          print('images::::images::::: $images');
          bodyParams.forEach((key, value) {
            request.fields[key] = value;
          });
          request.headers['Authorization'] = token ?? '';
          var response = await request.send();
          res = await http.Response.fromStream(response);
          if (kDebugMode) print("res.body:: ${res.body}");
          // ignore: unnecessary_null_comparison
          if (res != null) {
            return res;
          } else {
            return null;
          }
        } catch (e) {
          if (kDebugMode) print("ERROR:: $e");
           if (kDebugMode) print("CALLING:: Server Down");
        // MyLogger.logger.e("CALLING:: Server Down");
          //MyCommonMethods.serverDownShowSnackBar(context: context);
          return null;
        }

    } else {
      // CM.noInternet();
      return null;
    }
  }

  static Future<http.Response?> deleteMethod(
      {required String url,
      required Map<String, dynamic> bodyParams,
      Map<String, String>? token,
      required BuildContext context}) async {
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        http.Response? response =
            await http.delete(Uri.parse(url), body: bodyParams, headers: token);
        if (kDebugMode) print("CALLING:: ${response.body}");
        return response;
      } catch (e) {
        if (kDebugMode) print("ERROR:: $e");
        // ignore: use_build_context_synchronously
         if (kDebugMode) print("CALLING:: Server Down");
        // MyLogger.logger.e("CALLING:: Server Down");
        //MyCommonMethods.serverDownShowSnackBar(context: context);
        return null;
      }
    } else {
      // ignore: use_build_context_synchronously
      // CM.noInternet();
      return null;
    }
  }
}

/*  static Future<http.Response?> uploadMultipleImage(
      {required List<XFile> imageList,
        String? requestType,
        required String url,
        required String token,
        required String imageListKey}) async {
    http.Response? response;
    if (imageList.isNotEmpty) {
      for (int i = 0; i < imageList.length; i++) {
        http.MultipartRequest multipartRequest =
        http.MultipartRequest('POST', Uri.parse(url));
        multipartRequest.headers['Authorization'] = token;
        multipartRequest.files.add(http.MultipartFile.fromBytes(
            imageListKey, File(imageList[i].path).readAsBytesSync(),
            filename: imageList[i].path.split("/").last));
        http.StreamedResponse streamedResponse = await multipartRequest.send();
        response = await http.Response.fromStream(streamedResponse);
        print(imageList[i].path);
        return response;
      }
    }
    return null;
  }*/
/* static Future<http.Response?> uploadMultipleImageInMultipart
      ({
    required List<File> images,
    required String url,
    required String imageKey,
    required String multipartRequestType // POST or GET ,
    required Map<String, dynamic> bodyParams,
    required String token,
    required BuildContext context}) async {
    var request = http.MultipartRequest(multipartRequestType, Uri.parse(url));
    for (int i = 0; i < images.length; i++) {
      var stream = http.ByteStream(images[i].openRead());
      var length = await images[i].length();
      var multipartFile = http.MultipartFile(
        imageKey,
        stream,
        length,
        filename: images[i].path,
      );
      request.files.add(multipartFile);
    }
    var response = await request.send();
    if (kDebugMode) print("CALLING:: $response");
  }*/
/*
  static Future<http.Response?> uploadMultipleImage(
      {required List<XFile> imageList,
      String? requestType,
      required String url,
      required String token,
      required String imageListKey}) async {
    http.Response? response;
    if (imageList.isNotEmpty) {
      for (int i = 0; i < imageList.length; i++) {
        http.MultipartRequest multipartRequest =
            http.MultipartRequest('POST', Uri.parse(url));
        multipartRequest.headers['Authorization'] = token;
        multipartRequest.files.add(http.MultipartFile.fromBytes(
            imageListKey, File(imageList[i].path).readAsBytesSync(),
            filename: imageList[i].path.split("/").last));
        http.StreamedResponse streamedResponse = await multipartRequest.send();
        response = await http.Response.fromStream(streamedResponse);
        print(imageList[i].path);
        return response;
      }
    }
    return null;
  }*/
/*  static Future<http.Response?> uploadMultipleImage({
    required List<XFile> imageList,
    required String url,
    required String imageKey,
    required String multipartRequestType // POST or GET ,
    required Map<String, dynamic> bodyParams,
    required String token,
    required BuildContext context}) async {
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    if (kDebugMode) print("imageList:: $imageList");
    http.Response? res;
    if (await CM.internetConnectionCheckerMethod()) {
      if (imageList.isNotEmpty) {
        try {
          http.MultipartRequest multipartRequest =
          http.MultipartRequest(multipartRequestType, Uri.parse(url));
          bodyParams.forEach((key, value) {
            multipartRequest.fields[key] = value;
            if (kDebugMode) print(
                "multipartRequest.fields[key]:: $multipartRequest.fields[key]");
          });
          multipartRequest.headers['Authorization'] = token;
          for (var element in imageList) {
            multipartRequest.files.add(getUserProfileImageFile(
                image: File(element.path), userProfileImageKey: imageKey));
            if (kDebugMode) print("File(element.path):: ${File(element.path)}");
            if (kDebugMode) print("File(element.path):: ${element.path}");
          }
          http.StreamedResponse response = await multipartRequest.send();
          res = await http.Response.fromStream(response);
        } catch (e) {
          if (kDebugMode) print("ERROR:: $e");
           if (kDebugMode) print("CALLING:: Server Down");
        MyLogger.logger.e("CALLING:: Server Down");
          //MyCommonMethods.serverDownShowSnackBar(context: context);
          return null;
        }
        // ignore: unnecessary_null_comparison
        if (res != null) {
          if (kDebugMode) print("CALLING:: ${res.body}");
          return res;
        } else {
          return null;
        }
      } else {
        try {
          res = await http.post(
            Uri.parse(url),
            body: bodyParams,
            headers: {"authorization": token},
          );
        } catch (e) {
          if (kDebugMode) print("ERROR:: $e");
           if (kDebugMode) print("CALLING:: Server Down");
        MyLogger.logger.e("CALLING:: Server Down");
          //MyCommonMethods.serverDownShowSnackBar(context: context);
          return null;
        }
        // ignore: unnecessary_null_comparison
        if (res != null) {
          if (kDebugMode) print("CALLING:: ${res.body}");
          return res;
        } else {
          return null;
        }
      }
    } else {
      // CM.noInternet();
      return null;
    }
  }*/
