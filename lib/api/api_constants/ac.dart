

class AK {
  ///COMMON Api Key
  static const baseUrl = "baseUrl";

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
  static const baseUrlForSearchCompany = "http://192.168.1.229/Projects/GitLabProjects/company_master/api/";

  static const baseUrlForSearchCompanyImage = "http://192.168.1.229/Projects/GitLabProjects/company_master/";

  static const baseUrlAllApis = "http://192.168.1.229/Projects/GitLabProjects/co-manage/api/";

  static const baseUrlAllApisImage = "http://192.168.1.229/Projects/GitLabProjects/co-manage/";

  static const endPointCompanyControllerApi = "${baseUrlForSearchCompany}CompanyController.php";

  static const endPointLogInApi = "${baseUrlAllApis}AuthController.php";

  static const endPointRegistrationApi = "${baseUrlAllApis}AuthController.php";

  static const endPointSendOTPApi = "${baseUrlAllApis}AuthController.php";

  static const endPointMatchOTPApi = "${baseUrlAllApis}AuthController.php";

  static const endPointBranchApi = "${baseUrlAllApis}AuthController.php";

  static const endPointDepartmentApi = "${baseUrlAllApis}AuthController.php";

  static const endPointShiftTimeApi = "${baseUrlAllApis}AuthController.php";

  static const endPointGetCountryCodeApi = "${baseUrlAllApis}AuthController.php";




}