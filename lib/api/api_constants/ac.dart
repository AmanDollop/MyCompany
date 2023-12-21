

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
}

class AU {

  //BASEURL
  static const baseUrl = "http://192.168.1.246/Projects/GitLabProjects/company_master/api/";

  static const baseUrlForImage = "http://192.168.1.246/Projects/GitLabProjects/company_master/";

  static const baseUrlForGet = "http://192.168.1.246/Projects/GitLabProjects/co-manage/api/";


  static const endPointCompanyControllerApi = "${baseUrl}CompanyController.php";

  static const endPointLogInApi = "${baseUrl}AuthController.php";

  static const endPointBranchApi = "${baseUrlForGet}AuthController.php";

  static const endPointDepartmentApi = "${baseUrlForGet}AuthController.php";

  static const endPointShiftTimeApi = "${baseUrlForGet}AuthController.php";




}