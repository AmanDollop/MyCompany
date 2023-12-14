/*flutter pub add http :- For Http Calling Api*/
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:flutter/foundation.dart';

class HM {
  static final HM instance = HM._();

  HM._();

  Future<http.Response?> postRequest(
      {required String url,
      required Object bodyParams,
      Function(int)? getResponseCode}) async {
    String token = "";
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    if (kDebugMode) print("TOKEN:: $token");
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        http.Response? response =
            await http.post(Uri.parse(url), body: bodyParams, headers: {
          AK.accept: AK.applicationJson,
          AK.authorization: token,
        });
        getResponseCode?.call(response.statusCode);
        if (kDebugMode) print("RESPONSE:: ${response.body}");
        return response;
      } catch (e) {
        getResponseCode?.call(500);
        if (kDebugMode) print("ERROR:: $e");
        CM.error();
        return null;
      }
    } else {
      getResponseCode?.call(500);
      CM.noInternet();
      return null;
    }
  }

  Future<http.Response?> getRequest(
      {required String url, Function(int)? getResponseCode}) async {
    String token = "";
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("TOKEN:: $token");
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.get(
          Uri.parse(url),
          headers: {
            AK.authorization: token,
          },
        );
        getResponseCode?.call(response.statusCode);
        if (kDebugMode) print("RESPONSE:: ${response.body}");
        return response;
      } catch (e) {
        getResponseCode?.call(500);
        if (kDebugMode) print("ERROR:: $e");
        CM.error();
        return null;
      }
    } else {
      getResponseCode?.call(500);
      CM.noInternet();
      return null;
    }
  }

  Future<http.Response?> getRequestForParams(
      {required Map<String, dynamic> queryParameters,
      required String baseUriForParams,
      required String endPointUri,
      Function(int)? getResponseCode}) async {
    String token = "";
    Uri uri = Uri.http(
      baseUriForParams,
      endPointUri,
      queryParameters,
    );
    if (kDebugMode) print("CALLING:: $uri");
    if (kDebugMode) print("QUERYPARAMETERS:: $queryParameters");
    if (kDebugMode) print("TOKEN::  $token");
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.get(
          uri,
          headers: {
            AK.authorization: token,
          },
        );
        getResponseCode?.call(response.statusCode);
        if (kDebugMode) print("RESPONSE:: ${response.body}");
        return response;
      } catch (e) {
        getResponseCode?.call(500);
        if (kDebugMode) print("ERROR:: $e");
        CM.error();
        return null;
      }
    } else {
      getResponseCode?.call(500);
      CM.noInternet();
      return null;
    }
  }

  Future<http.Response?> deleteRequest({
    required String url,
    required  Object bodyParams,
    Function(int)? getResponseCode,
  }) async {
    String token = "";
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.delete(
          Uri.parse(url),
          body: bodyParams,
          headers: {
            AK.authorization: token,
          },
        );
        getResponseCode?.call(response.statusCode);
        if (kDebugMode) print("RESPONSE:: ${response.body}");
        return response;
      } catch (e) {
        getResponseCode?.call(500);
        if (kDebugMode) print("ERROR:: $e");
        CM.error();
        return null;
      }
    } else {
      getResponseCode?.call(500);
      CM.noInternet();
      return null;
    }
  }

  Future<http.Response?> updateMultipartRequestForSingleFile({
    File? image,
    required String url,
    required String multipartRequestType /* POST or GET */,
    required Map<String, dynamic> bodyParams,
    required String imageKey,
    Function(int)? getResponseCode,
  }) async {
    String token = "";
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    http.Response? response;
    if (await CM.internetConnectionCheckerMethod()) {
      if (image != null) {
        try {
          http.MultipartRequest multipartRequest =
              http.MultipartRequest(multipartRequestType, Uri.parse(url));
          bodyParams.forEach((key, value) {
            multipartRequest.fields[key] = value;
          });
          multipartRequest.headers[AK.authorization] = token;
          multipartRequest.files.add(
            http.MultipartFile.fromBytes(
              imageKey,
              image.readAsBytesSync(),
              filename: image.uri.pathSegments.last,
            ),
          );

          http.StreamedResponse res= await multipartRequest.send();
          response = await http.Response.fromStream(res);
          getResponseCode?.call(response.statusCode);
          if (kDebugMode) print("RESPONSE:: ${response.body}");
          return response;
        } catch (e) {
          getResponseCode?.call(500);
          if (kDebugMode) print("ERROR:: $e");
          CM.error();
          return null;
        }

      } else {
        try {
          response = await http.post(
            Uri.parse(url),
            body: bodyParams,
            headers: {AK.authorization: token},
          );
          getResponseCode?.call(response.statusCode);
          if (kDebugMode) print("RESPONSE:: ${response.body}");
          return response;
        } catch (e) {
          getResponseCode?.call(500);
          if (kDebugMode) print("ERROR:: $e");
          CM.error();
          return null;
        }
      }
    } else {
      getResponseCode?.call(500);
      CM.noInternet();
      return null;
    }
  }


}
