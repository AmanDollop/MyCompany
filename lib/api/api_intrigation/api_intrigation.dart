import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_model/branch_modal.dart';
import 'package:task/api/api_model/branch_modal.dart';
import 'package:task/api/api_model/branch_modal.dart';
import 'package:task/api/api_model/department_modal.dart';
import 'package:task/api/api_model/search_company_modal.dart';
import 'package:task/api/api_model/shift_time_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/my_http/my_http.dart';

class CAI{

  static Future<SearchCompanyModal?> searchCompanyApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    SearchCompanyModal? searchCompanyModal;
    http.Response? response = await MyHttp.postMethod(
      url: AU.endPointCompanyControllerApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        searchCompanyModal = SearchCompanyModal.fromJson(jsonDecode(response.body));
        return searchCompanyModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> logInApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: AU.endPointLogInApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<BranchModal?> branchApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    BranchModal? branchModal;
    http.Response? response = await MyHttp.postMethod(
      url: AU.endPointBranchApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        branchModal = BranchModal.fromJson(jsonDecode(response.body));
        return branchModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<DepartmentModal?> departmentApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    DepartmentModal? departmentModal;
    http.Response? response = await MyHttp.postMethod(
      url: AU.endPointDepartmentApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        departmentModal = DepartmentModal.fromJson(jsonDecode(response.body));
        return departmentModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ShiftTimeModal?> shiftTimeApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    ShiftTimeModal? shiftTimeApi;
    http.Response? response = await MyHttp.postMethod(
      url: AU.endPointShiftTimeApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        shiftTimeApi = ShiftTimeModal.fromJson(jsonDecode(response.body));
        return shiftTimeApi;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }



}