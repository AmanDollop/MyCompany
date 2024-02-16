import 'package:get/get.dart';

import '../modules/add_bank/bindings/add_bank_binding.dart';
import '../modules/add_bank/views/add_bank_view.dart';
import '../modules/add_document/bindings/add_document_binding.dart';
import '../modules/add_document/views/add_document_view.dart';
import '../modules/add_education/bindings/add_education_binding.dart';
import '../modules/add_education/views/add_education_view.dart';
import '../modules/add_experience/bindings/add_experience_binding.dart';
import '../modules/add_experience/views/add_experience_view.dart';
import '../modules/add_social_info/bindings/add_social_info_binding.dart';
import '../modules/add_social_info/views/add_social_info_view.dart';
import '../modules/add_sub_task/bindings/add_sub_task_binding.dart';
import '../modules/add_sub_task/views/add_sub_task_view.dart';
import '../modules/all_task/bindings/all_task_binding.dart';
import '../modules/all_task/views/all_task_view.dart';
import '../modules/attendance_tracker/bindings/attendance_tracker_binding.dart';
import '../modules/attendance_tracker/views/attendance_tracker_view.dart';
import '../modules/bank_detail/bindings/bank_detail_binding.dart';
import '../modules/bank_detail/views/bank_detail_view.dart';
import '../modules/bottom_navigation/bindings/bottom_navigation_binding.dart';
import '../modules/bottom_navigation/views/bottom_navigation_view.dart';
import '../modules/circular/bindings/circular_binding.dart';
import '../modules/circular/views/circular_view.dart';
import '../modules/circular_detail/bindings/circular_detail_binding.dart';
import '../modules/circular_detail/views/circular_detail_view.dart';
import '../modules/contact_detail/bindings/contact_detail_binding.dart';
import '../modules/contact_detail/views/contact_detail_view.dart';
import '../modules/document/bindings/document_binding.dart';
import '../modules/document/views/document_view.dart';
import '../modules/drawer_view/bindings/drawer_view_binding.dart';
import '../modules/drawer_view/views/drawer_view_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/education/bindings/education_binding.dart';
import '../modules/education/views/education_view.dart';
import '../modules/experience/bindings/experience_binding.dart';
import '../modules/experience/views/experience_view.dart';
import '../modules/face_detection/bindings/face_detection_binding.dart';
import '../modules/face_detection/views/face_detection_view.dart';
import '../modules/holiday/bindings/holiday_binding.dart';
import '../modules/holiday/views/holiday_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/job_info/bindings/job_info_binding.dart';
import '../modules/job_info/views/job_info_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menu_view/bindings/menu_view_binding.dart';
import '../modules/menu_view/views/menu_view_view.dart';
import '../modules/my_face_attendance/bindings/my_face_attendance_binding.dart';
import '../modules/my_face_attendance/views/my_face_attendance_view.dart';
import '../modules/my_profile/bindings/my_profile_binding.dart';
import '../modules/my_profile/views/my_profile_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/penalty/bindings/penalty_binding.dart';
import '../modules/penalty/views/penalty_view.dart';
import '../modules/personal_info/bindings/personal_info_binding.dart';
import '../modules/personal_info/views/personal_info_view.dart';
import '../modules/promotion/bindings/promotion_binding.dart';
import '../modules/promotion/views/promotion_view.dart';
import '../modules/search_company/bindings/search_company_binding.dart';
import '../modules/search_company/views/search_company_view.dart';
import '../modules/select_brance/bindings/select_brance_binding.dart';
import '../modules/select_brance/views/select_brance_view.dart';
import '../modules/select_department/bindings/select_department_binding.dart';
import '../modules/select_department/views/select_department_view.dart';
import '../modules/select_shift_time/bindings/select_shift_time_binding.dart';
import '../modules/select_shift_time/views/select_shift_time_view.dart';
import '../modules/shift_detail/bindings/shift_detail_binding.dart';
import '../modules/shift_detail/views/shift_detail_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/social_info/bindings/social_info_binding.dart';
import '../modules/social_info/views/social_info_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/sub_task/bindings/sub_task_binding.dart';
import '../modules/sub_task/views/sub_task_view.dart';
import '../modules/task_time_line/bindings/task_time_line_binding.dart';
import '../modules/task_time_line/views/task_time_line_view.dart';
import '../modules/utilities/bindings/utilities_binding.dart';
import '../modules/utilities/views/utilities_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding(),
        transitionDuration: const Duration(microseconds: 0)),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_COMPANY,
      page: () => const SearchCompanyView(),
      binding: SearchCompanyBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_BRANCE,
      page: () => const SelectBranceView(),
      binding: SelectBranceBinding(),
    ),
    GetPage(
      name: _Paths.UTILITIES,
      page: () => const UtilitiesView(),
      binding: UtilitiesBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION,
      page: () => const BottomNavigationView(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: _Paths.MENU_VIEW,
      page: () => const MenuViewView(),
      binding: MenuViewBinding(),
    ),
    GetPage(
        name: _Paths.NOTIFICATION,
        page: () => const NotificationView(),
        binding: NotificationBinding(),
        transitionDuration: const Duration(microseconds: 0)),
    GetPage(
        name: _Paths.DRAWER_VIEW,
        page: () => const DrawerViewView(),
        binding: DrawerViewBinding(),
        transitionDuration: const Duration(microseconds: 0)),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
        name: _Paths.MY_PROFILE,
        page: () => const MyProfileView(),
        binding: MyProfileBinding(),
        transitionDuration: const Duration(microseconds: 0)),
    GetPage(
      name: _Paths.SELECT_DEPARTMENT,
      page: () => const SelectDepartmentView(),
      binding: SelectDepartmentBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_SHIFT_TIME,
      page: () => const SelectShiftTimeView(),
      binding: SelectShiftTimeBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_DETAIL,
      page: () => const ContactDetailView(),
      binding: ContactDetailBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => const PersonalInfoView(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: _Paths.SOCIAL_INFO,
      page: () => const SocialInfoView(),
      binding: SocialInfoBinding(),
    ),
    GetPage(
      name: _Paths.BANK_DETAIL,
      page: () => const BankDetailView(),
      binding: BankDetailBinding(),
    ),
    GetPage(
      name: _Paths.EDUCATION,
      page: () => const EducationView(),
      binding: EducationBinding(),
    ),
    GetPage(
      name: _Paths.EXPERIENCE,
      page: () => const ExperienceView(),
      binding: ExperienceBinding(),
    ),
    GetPage(
      name: _Paths.PROMOTION,
      page: () => const PromotionView(),
      binding: PromotionBinding(),
    ),
    GetPage(
      name: _Paths.DOCUMENT,
      page: () => const DocumentView(),
      binding: DocumentBinding(),
    ),
    GetPage(
      name: _Paths.JOB_INFO,
      page: () => const JobInfoView(),
      binding: JobInfoBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BANK,
      page: () => const AddBankView(),
      binding: AddBankBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SOCIAL_INFO,
      page: () => const AddSocialInfoView(),
      binding: AddSocialInfoBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EDUCATION,
      page: () => const AddEducationView(),
      binding: AddEducationBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EXPERIENCE,
      page: () => const AddExperienceView(),
      binding: AddExperienceBinding(),
    ),
    GetPage(
      name: _Paths.SHIFT_DETAIL,
      page: () => const ShiftDetailView(),
      binding: ShiftDetailBinding(),
    ),
    GetPage(
      name: _Paths.MY_FACE_ATTENDANCE,
      page: () => const MyFaceAttendanceView(),
      binding: MyFaceAttendanceBinding(),
    ),
    GetPage(
        name: _Paths.CIRCULAR,
        page: () => const CircularView(),
        binding: CircularBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(microseconds: 0)),
    GetPage(
      name: _Paths.CIRCULAR_DETAIL,
      page: () => const CircularDetailView(),
      binding: CircularDetailBinding(),
    ),
    GetPage(
      name: _Paths.FACE_DETECTION,
      page: () => const FaceDetectionView(),
      binding: FaceDetectionBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DOCUMENT,
      page: () => const AddDocumentView(),
      binding: AddDocumentBinding(),
    ),
    GetPage(
        name: _Paths.ATTENDANCE_TRACKER,
        page: () => const AttendanceTrackerView(),
        binding: AttendanceTrackerBinding(),
        transitionDuration: const Duration(microseconds: 0)),
    GetPage(
      name: _Paths.ALL_TASK,
      page: () => const AllTaskView(),
      binding: AllTaskBinding(),
    ),
    GetPage(
      name: _Paths.SUB_TASK,
      page: () => const SubTaskView(),
      binding: SubTaskBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SUB_TASK,
      page: () => const AddSubTaskView(),
      binding: AddSubTaskBinding(),
    ),
    GetPage(
      name: _Paths.TASK_TIME_LINE,
      page: () => const TaskTimeLineView(),
      binding: TaskTimeLineBinding(),
    ),
    GetPage(
      name: _Paths.PENALTY,
      page: () => const PenaltyView(),
      binding: PenaltyBinding(),
    ),
    GetPage(
      name: _Paths.HOLIDAY,
      page: () => const HolidayView(),
      binding: HolidayBinding(),
    ),
  ];
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    HomeBinding();
    SplashBinding();
    LoginBinding();
    SignUpBinding();
    SearchCompanyBinding();
    SelectBranceBinding();
    UtilitiesBinding();
    BottomNavigationBinding();
    MenuViewBinding();
    NotificationBinding();
    DrawerViewBinding();
    EditProfileBinding();
    OtpVerificationBinding();
    MyProfileBinding();
    SelectDepartmentBinding();
    SelectShiftTimeBinding();
    ContactDetailBinding();
    PersonalInfoBinding();
  }
}
