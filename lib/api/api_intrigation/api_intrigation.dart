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
import 'package:task/api/api_model/get_all_leave_modal.dart';
import 'package:task/api/api_model/get_assign_template_modal.dart';
import 'package:task/api/api_model/get_break_details_modal.dart';
import 'package:task/api/api_model/get_department_employee_modal.dart';
import 'package:task/api/api_model/get_employee_details_modal.dart';
import 'package:task/api/api_model/get_leave_date_calender_modal.dart';
import 'package:task/api/api_model/get_leave_detail_modal.dart';
import 'package:task/api/api_model/get_leave_type_balance_count_modal.dart';
import 'package:task/api/api_model/get_leave_type_balance_modal.dart';
import 'package:task/api/api_model/get_leave_type_modal.dart';
import 'package:task/api/api_model/get_monthly_attendance_data_modal.dart';
import 'package:task/api/api_model/get_my_team_member_modal.dart';
import 'package:task/api/api_model/get_penalty_modal.dart';
import 'package:task/api/api_model/get_reporting_person_modal.dart';
import 'package:task/api/api_model/get_task_time_line_modal.dart';
import 'package:task/api/api_model/get_template_question_modal.dart';
import 'package:task/api/api_model/get_today_attendance_modal.dart';
import 'package:task/api/api_model/get_weekly_attendance_data_modal.dart';
import 'package:task/api/api_model/get_work_report_detail_modal.dart';
import 'package:task/api/api_model/get_work_report_modal.dart';
import 'package:task/api/api_model/holiday_modal.dart';
import 'package:task/api/api_model/menus_modal.dart';
import 'package:task/api/api_model/promotion_modal.dart';
import 'package:task/api/api_model/search_company_modal.dart';
import 'package:task/api/api_model/shift_details_modal.dart';
import 'package:task/api/api_model/shift_time_modal.dart';
import 'package:task/api/api_model/sub_task_data_modal.dart';
import 'package:task/api/api_model/sub_task_filter_data_modal.dart';
import 'package:task/api/api_model/task_data_modal.dart';
import 'package:task/api/api_model/upcoming_celebration_modal.dart';
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

  static Future<http.Response?> updateFcmIdApi({
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

  static Future<http.Response?> addDocumentApi({
    required Map<String, dynamic> bodyParams,
    File? filePath
  }) async {
    String baseUrl = await baseUrlReturn();

    String? token = await userToken(stringToken: true);

    http.Response? response = await MyHttp.multipartRequest(
        url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        userProfileImageKey: AK.documentFile,
        image: filePath,
        multipartRequestType: 'POST',
        token: '$token'
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

  static Future<HolidayModal?> getHolidayApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    HolidayModal? holidayModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointHolidayControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        holidayModal= HolidayModal.fromJson(jsonDecode(response.body));
        return holidayModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetWeeklyAttendanceDataModal?> getWeeklyAttendanceDataApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetWeeklyAttendanceDataModal? getWeeklyAttendanceDataModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAttendanceControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getWeeklyAttendanceDataModal = GetWeeklyAttendanceDataModal.fromJson(jsonDecode(response.body));
        return getWeeklyAttendanceDataModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> addAttendanceApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();
    Map<String, String> authorization = await userToken();
    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAttendanceControllerApi}',
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

  static Future<SubTaskFilterDataModal?> getSubTaskFilterDataApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    SubTaskFilterDataModal? getSubTaskFilterDataModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointTaskControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getSubTaskFilterDataModal = SubTaskFilterDataModal.fromJson(jsonDecode(response.body));
        return getSubTaskFilterDataModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<SubTaskDataModal?> getSubTaskDataApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    SubTaskDataModal? getSubTaskDataModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointTaskControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getSubTaskDataModal = SubTaskDataModal.fromJson(jsonDecode(response.body));
        return getSubTaskDataModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> addSubTaskApi({
    required Map<String, dynamic> bodyParams,
    File? filePath
  }) async {
    String baseUrl = await baseUrlReturn();

    String? token = await userToken(stringToken: true);

    http.Response? response = await MyHttp.multipartRequest(
        url: '$baseUrl${AU.endPointTaskControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        userProfileImageKey: AK.taskAttachment,
        image: filePath,
        multipartRequestType: 'POST',
        token: '$token'
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

  static Future<GetTaskTimeLineModal?> getTaskTimeLineApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetTaskTimeLineModal? getTaskTimeLineModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointTaskControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getTaskTimeLineModal = GetTaskTimeLineModal.fromJson(jsonDecode(response.body));
        return getTaskTimeLineModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<UpcomingCelebrationModal?> getUpcomingCelebrationApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    UpcomingCelebrationModal? upcomingCelebrationModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointCelebrationControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        upcomingCelebrationModal = UpcomingCelebrationModal.fromJson(jsonDecode(response.body));
        return upcomingCelebrationModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetDepartmentEmployeeModal?> getDepartmentEmployeeApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetDepartmentEmployeeModal? getDepartmentEmployeeModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointAuthControllerPhpApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getDepartmentEmployeeModal = GetDepartmentEmployeeModal.fromJson(jsonDecode(response.body));
        return getDepartmentEmployeeModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetMyTeamMemberModal?> getMyTeamMemberApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetMyTeamMemberModal? getMyTeamMemberModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getMyTeamMemberModal = GetMyTeamMemberModal.fromJson(jsonDecode(response.body));
        return getMyTeamMemberModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetReportingPersonModal?> getReportingPersonApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetReportingPersonModal? getReportingPersonModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointUserControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getReportingPersonModal = GetReportingPersonModal.fromJson(jsonDecode(response.body));
        return getReportingPersonModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetPenaltyModal?> getPenaltyApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetPenaltyModal? getPenaltyModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointPenaltyControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getPenaltyModal = GetPenaltyModal.fromJson(jsonDecode(response.body));
        return getPenaltyModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetLeaveDateCalenderModal?> getLeaveDateCalenderApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetLeaveDateCalenderModal? getLeaveDateCalenderModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointLeaveControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getLeaveDateCalenderModal = GetLeaveDateCalenderModal.fromJson(jsonDecode(response.body));
        return getLeaveDateCalenderModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetLeaveTypeModal?> getLeaveTypeModalApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetLeaveTypeModal? getLeaveTypeModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointLeaveControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getLeaveTypeModal = GetLeaveTypeModal.fromJson(jsonDecode(response.body));
        return getLeaveTypeModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetLeaveTypeBalanceModal?> getLeaveTypeBalanceApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetLeaveTypeBalanceModal? getLeaveTypeBalanceModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointLeaveControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getLeaveTypeBalanceModal = GetLeaveTypeBalanceModal.fromJson(jsonDecode(response.body));
        return getLeaveTypeBalanceModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetAllLeaveModal?> getAllLeaveApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetAllLeaveModal? getAllLeaveModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointLeaveControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getAllLeaveModal = GetAllLeaveModal.fromJson(jsonDecode(response.body));
        return getAllLeaveModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetLeaveDetailModal?> getLeaveDetailApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetLeaveDetailModal? getLeaveDetailModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointLeaveControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getLeaveDetailModal = GetLeaveDetailModal.fromJson(jsonDecode(response.body));
        return getLeaveDetailModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> addLeaveApi({
    required Map<String, dynamic> bodyParams,
    File? filePath
  }) async {
    String baseUrl = await baseUrlReturn();

    String? token = await userToken(stringToken: true);

    http.Response? response = await MyHttp.multipartRequest(
        url: '$baseUrl${AU.endPointLeaveControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        userProfileImageKey: AK.leaveAttachment,
        image: filePath,
        multipartRequestType: 'POST',
        token: '$token'
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

  static Future<GetLeaveTypeBalanceCountModal?> getLeaveBalanceCountApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetLeaveTypeBalanceCountModal? getLeaveTypeBalanceCountModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointLeaveControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getLeaveTypeBalanceCountModal = GetLeaveTypeBalanceCountModal.fromJson(jsonDecode(response.body));
        return getLeaveTypeBalanceCountModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetWorkReportModal?> getWorkReportApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetWorkReportModal? getWorkReportModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointWorkReportControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);

    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getWorkReportModal = GetWorkReportModal.fromJson(jsonDecode(response.body));
        return getWorkReportModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> addWorkReportApi({
    required Map<String, dynamic> bodyParams,
    required List<File> filePath
  }) async {
    String baseUrl = await baseUrlReturn();

    String? token = await userToken(stringToken: true);

    http.Response? response = await MyHttp.uploadMultipleImagesWithBody(
        uri: '$baseUrl${AU.endPointWorkReportControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        imageKey: AK.workReportFile,
        images: filePath,
        multipartRequestType: 'POST',
        token: '$token'
    );
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true,wantShowSuccessResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetWorkReportDetailModal?> getWorkReportDetailApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetWorkReportDetailModal? getWorkReportDetailModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointWorkReportControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);

    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getWorkReportDetailModal = GetWorkReportDetailModal.fromJson(jsonDecode(response.body));
        return getWorkReportDetailModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetAssignTemplateModal?> getAssignTemplateApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetAssignTemplateModal? getAssignTemplateModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointWorkReportControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);

    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getAssignTemplateModal = GetAssignTemplateModal.fromJson(jsonDecode(response.body));
        return getAssignTemplateModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetTemplateQuestionModal?> getTemplateQuestionApi({
    required Map<String, dynamic> bodyParams,
  }) async {

    String baseUrl = await baseUrlReturn();

    GetTemplateQuestionModal? getTemplateQuestionModal;

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointWorkReportControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);

    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true)) {
        getTemplateQuestionModal = GetTemplateQuestionModal.fromJson(jsonDecode(response.body));
        return getTemplateQuestionModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> submitTemQuestionApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String baseUrl = await baseUrlReturn();

    Map<String, String> authorization = await userToken();

    http.Response? response = await MyHttp.postMethod(
        url: '$baseUrl${AU.endPointWorkReportControllerApi}',
        bodyParams: bodyParams,
        context: Get.context!,
        token: authorization,
        showSnackBar: false);
    if (response != null) {
      if (await CM.checkResponse(response: response, wantInternetFailResponse: true, wantShowFailResponse: true,wantShowSuccessResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

}
