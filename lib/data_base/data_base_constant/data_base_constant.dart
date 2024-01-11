class DataBaseConstant {

  static String dataBaseName = 'USER_DATA.db';

  static String columnId = 'COLUMN_ID';
  static String version = 'VERSION_CODE';


  ///TODO Table Name's
  // static String tableNameForUserToken = 'USERS_TOKEN';
  // static String tableNameForPersonalInfo = 'PERSONAL_INFO';
  // static String tableNameForContactInfo = 'CONTACT_INFO';
  // static String tableNameForJobInfo = 'JOB_INFO';
  // static String tableNameForSocialInfo = 'SOCIAL_INFO';
  static String tableNameForUserDetail = 'USER_DETAIL';
  static String tableNameForCompanyDetail = 'COMPANY_DETAIL';
  static String tableNameForShiftDetail = 'SHIFT_DETAIL';
  static String tableNameForProfileMenu = 'PROFILE_MENU';
  static String tableNameForAppMenu = 'APP_MENU';


  ///TODO Table Name User_Token for key
  static String userToken = 'token';


  ///TODO Table Name User_Token for key
  static String userDetail = 'user_detail';

  ///TODO Table Name COMPANY_DETAIL for key
  static String companyDetail = 'company_detail';

  ///TODO Table Name SHIFT_DETAIL for key
  static String shiftDetails = 'shiftDetails';
  static String shiftTime = 'shiftTime';

  ///TODO Table Name PROFILE_MENU for key
  static String profileMenuDetails = 'getEmployeeDetails';

  ///TODO Table Name APP_MENU for key
  static String appMenus = 'appMenus';

}

class DataBaseType {
  static String autoIncrementUserId= 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static String textType='TEXT_TYPE';
}


