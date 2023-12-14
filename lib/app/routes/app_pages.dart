import 'package:get/get.dart';

import '../modules/bottom_navigation/bindings/bottom_navigation_binding.dart';
import '../modules/bottom_navigation/views/bottom_navigation_view.dart';
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
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/search_company/bindings/search_company_binding.dart';
import '../modules/search_company/views/search_company_view.dart';
import '../modules/select_brance/bindings/select_brance_binding.dart';
import '../modules/select_brance/views/select_brance_view.dart';
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
  ];
}
