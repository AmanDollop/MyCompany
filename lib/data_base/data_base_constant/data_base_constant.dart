class DataBaseConstant {

  static String dataBaseName = 'USER_DATA.db';

  static String columnId = 'COLUMN_ID';
  static String version = 'VERSION_CODE';


  ///TODO Table Name's
  static String tableNameForUserToken = 'USERS_TOKEN';
  static String tableNameForPersonalInfo = 'PERSONAL_INFO';
  static String tableNameForContactInfo = 'CONTACT_INFO';
  static String tableNameForJobInfo = 'JOB_INFO';
  static String tableNameForSocialInfo = 'SOCIAL_INFO';
  static String tableNameForCompanyDetail = 'COMPANY_DETAIL';


  ///TODO Table Name User_Token for key
  static String userToken = 'token';


  ///TODO Table Name PERSONAL_INFO for key
  static String companyId = 'company_id';
  static String userFirstName = 'user_first_name';
  static String userMiddleName = 'user_middle_name';
  static String userLastName = 'user_last_name';
  static String userFullName = 'user_full_name';
  static String gender = 'gender';
  static String bloodGroup = 'blood_group';
  static String userProfilePic = 'user_profile_pic';
  static String memberDatePOfBirth = 'member_date_of_birth';
  static String hobbiesAndInterest = 'hobbies_and_interest';
  static String skills = 'skills';
  static String languageKnown = 'language_known';


  ///TODO Table Name CONTACT_INFO for key
  static String countryCode = 'country_code';
  static String userMobile = 'user_mobile';
  static String whatsappCountryCode = 'whatsapp_country_code';
  static String whatsappNumber = 'whatsapp_number';
  static String personalEmail = 'personal_email';
  static String userEmail = 'user_email';
  static String currentAddress = 'current_address';
  static String permanentAddress = 'permanent_address';
  static String userMobilePrivacy = 'user_mobile_privacy';
  static String whatsappNumberPrivacy = 'whatsapp_number_privacy';
  static String userEmailPrivacy = 'user_email_privacy';
  static String personalEmailPrivacy = 'personal_email_privacy';
  static String currentAddressPrivacy = 'current_address_privacy';
  static String permanentAddressPrivacy = 'permanent_address_privacy';


  ///TODO Table Name JOB_INFO for key
  static String userDesignation = 'user_designation';
  static String dateOfJoining = 'date_of_joining';
  static String employeeId = 'employee_id';
  static String employeeType = 'employee_type';
  static String employeeTypeView = 'employee_type_view';
  static String branchName = 'branch_name';
  static String departmentName = 'department_name';
  static String branchId = 'branch_id';
  static String departmentId = 'department_id';


  ///TODO Table Name SOCIAL_INFO for key
  static String twitter = 'twitter';
  static String linkedin = 'linkedin';
  static String instagram = 'instagram';
  static String facebook = 'facebook';
  static String socialLinksPrivacy = 'social_links_privacy';




  ///TODO Table Name COMPANY_DETAIL for key
  static String companyIdFormCompanyDetail = 'company_id';
  static String countryId = 'country_id';
  static String companyName = 'company_name';
  static String companyAddress = 'company_address';
  static String companyLatitude = 'company_latitude';
  static String companyLongitude = 'company_longitude';
  static String companyLogo = 'company_logo';

}

class DataBaseType {
  static String autoIncrementUserId= 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static String textType='TEXT_TYPE';
}


