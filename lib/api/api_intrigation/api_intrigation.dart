import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_model/bank_detail_modal.dart';
import 'package:task/api/api_model/blood_group_modal.dart';
import 'package:task/api/api_model/branch_modal.dart';
import 'package:task/api/api_model/circular_detail_modal.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/country_code_modal.dart';
import 'package:task/api/api_model/department_modal.dart';
import 'package:task/api/api_model/document_modal.dart';
import 'package:task/api/api_model/education_modal.dart';
import 'package:task/api/api_model/experience_modal.dart';
import 'package:task/api/api_model/get_break_details_modal.dart';
import 'package:task/api/api_model/get_employee_details_modal.dart';
import 'package:task/api/api_model/get_monthly_attendance_data_modal.dart';
import 'package:task/api/api_model/get_today_attendance_modal.dart';
import 'package:task/api/api_model/menus_modal.dart';
import 'package:task/api/api_model/promotion_modal.dart';
import 'package:task/api/api_model/search_company_modal.dart';
import 'package:task/api/api_model/shift_details_modal.dart';
import 'package:task/api/api_model/shift_time_modal.dart';
import 'package:task/api/api_model/task_data_modal.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/my_http/my_http.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class CAI extends GetxController{

  static Future<String> baseUrlReturn() async {
    String baseUrlAll = await CM.getString(key: AK.baseUrl) ?? '';
    return baseUrlAll;
  }

  static userToken({bool stringToken = false}) async {
    final userDataFromLocalDataBase = ''.obs;
    UserDetails? userData;
    final token = ''.obs;
    Map<String, String> authorization = {};

    userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(key:DataBaseConstant.userDetail,tableName: DataBaseConstant.tableNameForUserDetail);

    userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;

    token.value = '${AK.bearer} ${userData?.token}';

    authorization = {
      AK.authorization: token.value,
    };
    if(stringToken){
      return token.value;
    }else{
      return authorization;
    }
  }

  static Future<SearchCompanyModal?> searchCompanyApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    SearchCompanyModal? searchCompanyModal;
    http.Response? response = await MyHttp.postMethod(
      url: AU.endPointCompanyControllerApi,
      bodyParams: bodyParams,
      context: Get.context!,
      showSnackBar: false,
    );
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        searchCompanyModal = SearchCompanyModal.fromJson(jsonDecode(response.body));
        return searchCompanyModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> registrationApi({
    required Map<String, dynamic> bodyParams,
    required Map<String, File> imageMap,
  }) async {
    String baseUrl = await baseUrlReturn();
    http.Response? response = await MyHttp.multipartRequestForSignUp(
      url: '$baseUrl${AU.endPointAuthControllerPhpApi}',
      bodyParams: bodyParams,
      context: Get.context!,
      imageMap: imageMap,
      multipartRequestType: 'POST',
    );
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> sendOtpApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();
    http.Response? response = await MyHttp.postMethod(
      url: '$baseUrl${AU.endPointAuthControllerPhpApi}',
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<UserDataModal?> matchOtpApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();
    UserDataModal? userDataModal;
    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAuthControllerPhpApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        userDataModal = UserDataModal.fromJson(jsonDecode(response.body));
        return userDataModal;
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
    String baseUrl = await baseUrlReturn();
    BranchModal? branchModal;
    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAuthControllerPhpApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
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
    String baseUrl = await baseUrlReturn();
    DepartmentModal? departmentModal;
    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAuthControllerPhpApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
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
    String baseUrl = await baseUrlReturn();
    ShiftTimeModal? shiftTimeApi;
    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAuthControllerPhpApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        shiftTimeApi = ShiftTimeModal.fromJson(jsonDecode(response.body));
        return shiftTimeApi;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<CountryCodeModal?> getCountryCodeApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();
    CountryCodeModal? countryCodeModal;
    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAuthControllerPhpApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        countryCodeModal = CountryCodeModal.fromJson(jsonDecode(response.body));
        return countryCodeModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<CompanyDetailsModal?> getCompanyDetailsApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();

    CompanyDetailsModal? companyDetailsModal;
    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointCompanyControllerDetailPhpApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        companyDetailsModal = CompanyDetailsModal.fromJson(jsonDecode(response.body));
        return companyDetailsModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetEmployeeDetailsModal?> getEmployeeDetailsApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetEmployeeDetailsModal? getEmployeeDetailsModal;


    Map<String, String> authorization = await userToken();

      http.Response? response = await MyHttp.postMethod(
          url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
       if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getEmployeeDetailsModal = GetEmployeeDetailsModal.fromJson(jsonDecode(response.body));
        return getEmployeeDetailsModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<UserDataModal?> getUserDataApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    UserDataModal? getUserData;

    Map<String, String> authorization = await userToken();

      http.Response? response = await MyHttp.postMethod(
          url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
       if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getUserData = UserDataModal.fromJson(jsonDecode(response.body));
        return getUserData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> updateProfileApi({
    required Map<String, dynamic> bodyParams,
    File? image
  }) async {

    String baseUrl = await baseUrlReturn();

    String? token = await userToken(stringToken: true);

    http.Response? response = await MyHttp.multipartRequest(
        url: '$baseUrl${AU.endPointUserControllerApi}',
      bodyParams: bodyParams,
      context: Get.context!,
      userProfileImageKey: AK.userProfilePic,
      image: image,
      multipartRequestType: 'POST',
      token: '$token'
    );
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> updateUserControllerApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointUserControllerApi}',
      bodyParams: bodyParams,
      context: Get.context!,
      token: authorization
    );
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<BankDetailModal?> getBankDetailApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    BankDetailModal? bankDetail;

   Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        bankDetail = BankDetailModal.fromJson(jsonDecode(response.body));
        return bankDetail;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<EducationDetailsModal?> getEducationOrAchievementsApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    EducationDetailsModal? educationModal;

   Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        educationModal = EducationDetailsModal.fromJson(jsonDecode(response.body));
        return educationModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<BloodGroupModal?> getBloodGroupApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();
    BloodGroupModal? bloodGroupModal;
    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAuthControllerPhpApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        bloodGroupModal = BloodGroupModal.fromJson(jsonDecode(response.body));
        return bloodGroupModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<DocumentModal?> getDocumentApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    DocumentModal? documentModal;

   Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        documentModal = DocumentModal.fromJson(jsonDecode(response.body));
        return documentModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ExperienceModal?> getExperienceApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    ExperienceModal? experienceModal;

   Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        experienceModal = ExperienceModal.fromJson(jsonDecode(response.body));
        return experienceModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<PromotionModal?> getPromotionApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    PromotionModal? promotionModal;

   Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        promotionModal = PromotionModal.fromJson(jsonDecode(response.body));
        return promotionModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ShiftDetailsModal?> getShiftDetailApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    ShiftDetailsModal? shiftDetailsModal;

   Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointShiftControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        shiftDetailsModal = ShiftDetailsModal.fromJson(jsonDecode(response.body));
        return shiftDetailsModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<MenusModal?> menusApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    MenusModal? menusModal;
    http.Response? response = await MyHttp.postMethod(
      url: AU.endPointCompanyControllerApi,
      bodyParams: bodyParams,
      context: Get.context!,
      showSnackBar: false,
    );
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        menusModal = MenusModal.fromJson(jsonDecode(response.body));
        return menusModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<CircularDetailModal?> getCircularDetailApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    CircularDetailModal? circularDetailModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointCircularControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        circularDetailModal = CircularDetailModal.fromJson(jsonDecode(response.body));
        return circularDetailModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetTodayAttendanceModal?> getTodayAttendanceApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetTodayAttendanceModal? getTodayAttendanceModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAttendanceControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getTodayAttendanceModal = GetTodayAttendanceModal.fromJson(jsonDecode(response.body));
        return getTodayAttendanceModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetBreakDetailsModal?> getBreakDetailsApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetBreakDetailsModal? getBreakModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getBreakModal = GetBreakDetailsModal.fromJson(jsonDecode(response.body));
        return getBreakModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> attendancePunchInAndPunchOutApi({
    required Map<String, dynamic> bodyParams,
    File? image,
    required String userProfileImageKey
  }) async {

    String baseUrl = await baseUrlReturn();

    String? token = await userToken(stringToken: true);

    http.Response? response = await MyHttp.multipartRequest(
        url: '$baseUrl${AU.endPointAttendanceControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        userProfileImageKey: userProfileImageKey,
        image: image,
        multipartRequestType: 'POST',
        token: '$token'
    );
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> breakInAndOutApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();
    Map<String, String> authorization = await userToken();
    http.Response? response = await MyHttp.postMethod(
      url: '$baseUrl${AU.endPointBreakControllerApi}',
      bodyParams: bodyParams,
      context: Get.context!,
      token: authorization
    );
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetMonthlyAttendanceDataModal?> getMonthlyAttendanceDataApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetMonthlyAttendanceDataModal? getMonthlyAttendanceDataModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAttendanceControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getMonthlyAttendanceDataModal = GetMonthlyAttendanceDataModal.fromJson(jsonDecode(response.body));
        return getMonthlyAttendanceDataModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> addTaskApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();
    Map<String, String> authorization = await userToken();
    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointTaskControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization
    );
    if (response != null) {
      if (await CM.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<TaskDataModal?> getTaskDataApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    TaskDataModal? getMonthlyAttendanceDataModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointTaskControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getMonthlyAttendanceDataModal = TaskDataModal.fromJson(jsonDecode(response.body));
        return getMonthlyAttendanceDataModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


}
