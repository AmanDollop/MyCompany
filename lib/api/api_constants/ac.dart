

class AK {
  ///COMMON Api Key
  static const limit="limit";

  static const offset="offset";

  static const accept="Accept";

  static const applicationJson="application/json";

  static const authorization="Authorization";

  static const message="message";

  static const action="action";

  static const searchString="searchStr";

  static const userEmail="user_email";

  static const userPassword="user_password";

  static const companyId="company_id";

  static const branchId="branch_id";

  static const userFirstName="user_first_name";

  static const userLastName="user_last_name";

  static const userProfilePic="user_profile_pic";

  static const departmentId="department_id";

  static const shiftId="shift_id";

  static const dateOfJoining="date_of_joining";

  static const userDesignation="user_designation";

  static const useMobile="user_mobile";

  static const gender="gender";

  static const deviceType="deviceType";

  static const countryCode="country_code";

  static const otp="otp";


}

class AU {

  //BASEURL
  static const baseUrl = "http://192.168.1.246/Projects/GitLabProjects/company_master/api/";

  static const baseUrlForImage = "http://192.168.1.246/Projects/GitLabProjects/company_master/";

  static const baseUrlFor1 = "http://192.168.1.229/Projects/GitLabProjects/co-manage/api/";

  static const baseUrlForImage1 = "http://192.168.1.229/Projects/GitLabProjects/co-manage/";

  static const baseUrlForGet = "http://192.168.1.246/Projects/GitLabProjects/co-manage/api/";

  static const endPointCompanyControllerApi = "${baseUrl}CompanyController.php";

  static const endPointLogInApi = "${baseUrlFor1}AuthController.php";

  static const endPointRegistrationApi = "${baseUrlFor1}AuthController.php";

  static const endPointSendOTPApi = "${baseUrlFor1}AuthController.php";

  static const endPointMatchOTPApi = "${baseUrlFor1}AuthController.php";

  static const endPointBranchApi = "${baseUrlForGet}AuthController.php";

  static const endPointDepartmentApi = "${baseUrlForGet}AuthController.php";

  static const endPointShiftTimeApi = "${baseUrlForGet}AuthController.php";

  static const endPointGetCountryCodeApi = "${baseUrlFor1}AuthController.php";




}