class AK {
  ///COMMON Api Key
  static const baseUrl = "baseUrl";

  static const limit="limit";

  static const offset="offset";

  static const accept="Accept";

  static const applicationJson="application/json";

  static const bearer = "Bearer";

  static const authorization="Authorization";

  static const message="message";

  static const searchString="searchStr";

  static const userEmail="user_email";

  static const userPassword="user_password";

  static const companyId="company_id";

  static const branchId="branch_id";

  static const userFirstName="user_first_name";

  static const userLastName="user_last_name";

  static const userProfilePic = "user_profile_pic";

  static const documentFile = "document_file";

  static const documentName = "document_name";

  static const memberDateOfBirth = "member_date_of_birth";

  static const hobbiesAndInterest = "hobbies_and_interest";

  static const skills = "skills";

  static const languageKnown = "language_known";

  static const departmentId="department_id";

  static const shiftId="shift_id";

  static const dateOfJoining="date_of_joining";

  static const userDesignation="user_designation";

  static const useMobile="user_mobile";

  static const gender="gender";

  static const bloodGroup="blood_group";

  static const deviceType="deviceType";

  static const countryCode="country_code";

  static const otp="otp";

  static const whatsappCountryCode="whatsapp_country_code";

  static const whatsappNumber="whatsapp_number";

  static const personalEmail="personal_email";

  static const currentAddress="current_address";

  static const permanentAddress="permanent_address";

  static const accountHoldersName="account_holders_name";
  static const bankName="bank_name";
  static const bankId="bank_id";
  static const bankBranchName="bank_branch_name";
  static const accountNo="account_no";
  static const accountType="account_type";
  static const ifscCode="ifsc_code";
  static const crnNo="crn_no";
  static const panCardNo="pan_card_no";
  static const esicNo="esic_no";
  static const pfNo="pf_no";

  static const experienceId="experience_id";
  static const companyName="company_name";
  static const designation="designation";
  static const joiningDate="joining_date";
  static const releaseDate="release_date";
  static const companyLocation="company_location";

  static const educationAchievementId = "education_achievement_id";
  static const classAchievement = "class_achievement";
  static const type = "type";
  static const universityLocation = "university_location";
  static const year = "year";
  static const remark = "remark";
  static const createdDate = "created_date";

  static const twitter = "twitter";
  static const facebook = "facebook";
  static const instagram = "instagram";
  static const linkedin = "linkedin";

  static const lateInReason = "late_in_reason";
  static const punchInLatitude = "punch_in_latitude";
  static const punchInLongitude = "punch_in_longitude";
  static const punchInRange = "punch_in_range";
  static const punchLateIn = "late_in";
  static const punchInOutOfRange = "punch_in_out_of_range";
  static const punchInOutOfRangeReason = "punch_in_out_of_range_reason";
  static const punchInImage = "punch_in_image";
  static const shiftType = "shift_type";

  static const punchOutLatitude = "punch_out_latitude";
  static const punchOutLongitude = "punch_out_longitude";
  static const punchOutImage = "punch_out_image";
  static const earlyOut = "early_out";
  static const punchOutOutOfRangeReason = "punch_out_out_of_range_reason";
  static const punchOutOutOfRange = "punch_out_out_of_range";
  static const earlyOutReason = "early_out_reason";
  static const punchOutRange = "punch_out_range";

  static const breakTypeId = "break_type_id";
  static const breakStartLatitude = "break_start_latitude";
  static const breakStartLongitude = "break_start_longitude";
  static const breakEndLatitude = "break_end_latitude";
  static const breakEndLongitude = "break_end_longitude";
  static const breakTypeName = "break_type_name";
  static const attendanceId = "attendance_id";
  static const breakHistoryId = "break_history_id";

  static const startDate = "startDate";
  static const endDate = "endDate";
  static const search = "search";

  static const action = "action";

  static const month = "month";

  static const taskCategoryName = "task_category_name";
  static const taskCategoryId = "task_category_id";
  static const statusFilter = "status_filter";
  static const taskId = "task_id";
  static const taskStatus = "task_status";
  static const taskTimelineDescription = "task_timeline_description";

  static const taskAttachment = "task_attachment";
  static const taskPriority = "task_priority";
  static const taskStartDate = "task_start_date";
  static const taskDueDate = "task_due_date";
  static const taskDueTime = "task_due_time";
  static const taskName = "task_name";
  static const taskNote = "task_note";
  static const taskAssignTo = "task_assign_to";

}

class AU {

  //BASEURL
  static const baseUrlForSearchCompany = "http://192.168.1.229/Projects/GitLabProjects/company_master/api/";

  static const baseUrlForSearchCompanyImage = "http://192.168.1.229/Projects/GitLabProjects/company_master/";

  static const baseUrlAllApis = "http://192.168.1.229/Projects/GitLabProjects/co-manage/api/";

  static const baseUrlAllApisImage = "http://192.168.1.229/Projects/GitLabProjects/co-manage/";

  static const endPointCompanyControllerApi = "${baseUrlForSearchCompany}CompanyController.php";



  static const endPointAuthControllerPhpApi = "api/AuthController.php";

  static const endPointCompanyControllerDetailPhpApi = "api/companyController.php";

  static const endPointUserControllerApi = "api/UserController.php";

  static const endPointShiftControllerApi = "api/ShiftController.php";

  static const endPointAttendanceControllerApi = "api/AttendanceController.php";

  static const endPointCircularControllerApi = "api/CircularController.php";

  static const endPointBreakControllerApi = "api/BreakController.php";

  static const endPointTaskControllerApi = "api/TaskController.php";





}

class ApiEndPointAction{

  static const addBankDetail = "addBankDetail";

  static const addEducation = 'addEducation';

  static const addExperience = 'addExperience';

  static const updateSocialInfo = 'updateSocialInfo';

  static const getBankDetails = 'getBankDetails';

  static const primaryKeySet = 'primaryKeySet';

  static const deleteBankDetail = 'deleteBankDetail';

  static const getCirculars = 'getCirculars';

  static const getCountryCode = 'getCountryCode';

  static const updateContactInfo = 'updateContactInfo';

  static const getDocument = 'getDocument';

  static const addDocument = 'addDocument';

  static const updatePersonalInfo = 'updatePersonalInfo';

  static const getBloodGroup = 'getBloodGroup';

  static const getEducationDetails = 'getEducationDetails';

  static const getExperience = 'getExperience';

  static const getBreak = 'getBreak';

  static const getDashboardMenu = 'getDashboardMenu';

  static const getTodayAttendance = 'getTodayAttendance';

  static const attendancePunchIn = 'attendancePunchIn';

  static const attendancePunchOut = 'attendancePunchOut';

  static const breakIn = 'breakIn';

  static const breakOut = 'breakOut';

  static const userSentOtp = 'userSentOtp';

  static const getEmployeeProfileMenu = 'getEmployeeProfileMenu';

  static const getPromotion = 'getPromotion';

  static const getCompanies = 'getCompanies';

  static const getBranches = 'getBranches';

  static const getDepartments = 'getDepartments';

  static const getShifts = 'getShifts';

  static const userRegistration = 'userRegistration';

  static const matchOtp = 'matchOtp';

  static const getCompanyDetail = 'getCompanyDetail';

  static const getUserDetails = 'getUserDetails';

  static const getShiftDetail = 'getShiftDetail';

  static const getMonthlyAttendanceHistoryNew = 'getMonthlyAttendanceHistoryNew';

  static const addTaskCategory = 'addTaskCategory';

  static  const deleteTaskCategory = 'deleteTaskCategory';

  static  const deleteTask = 'deleteTask';

  static  const changeTaskStatus = 'changeTaskStatus';

  static  const getTaskCategory = 'getTaskCategory';

  static  const getTaskStatus = 'getTaskStatus';

  static  const getTask = 'getTask';

  static  const addTask = 'addTask';


}