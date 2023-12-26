import 'package:get/get.dart';

import '../modules/bottom_navigation/bindings/bottom_navigation_binding.dart';
import '../modules/bottom_navigation/views/bottom_navigation_view.dart';
import '../modules/contact_detail/bindings/contact_detail_binding.dart';
import '../modules/contact_detail/views/contact_detail_view.dart';
import '../modules/drawer_view/bindings/drawer_view_binding.dart';
import '../modules/drawer_view/views/drawer_view_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menu_view/bindings/menu_view_binding.dart';
import '../modules/menu_view/views/menu_view_view.dart';
import '../modules/my_profile/bindings/my_profile_binding.dart';
import '../modules/my_profile/views/my_profile_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/personal_info/bindings/personal_info_binding.dart';
import '../modules/personal_info/views/personal_info_view.dart';
import '../modules/search_company/bindings/search_company_binding.dart';
import '../modules/search_company/views/search_company_view.dart';
import '../modules/select_brance/bindings/select_brance_binding.dart';
import '../modules/select_brance/views/select_brance_view.dart';
import '../modules/select_department/bindings/select_department_binding.dart';
import '../modules/select_department/views/select_department_view.dart';
import '../modules/select_shift_time/bindings/select_shift_time_binding.dart';
import '../modules/select_shift_time/views/select_shift_time_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
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
    ),
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
    ),
    GetPage(
      name: _Paths.DRAWER_VIEW,
      page: () => const DrawerViewView(),
      binding: DrawerViewBinding(),
    ),
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
    ),
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
  ];
}

class InitialBinding extends Bindings{
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
