import 'package:get/get.dart';

import '../controllers/menu_view_controller.dart';

class MenuViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuViewController>(
      () => MenuViewController(),
    );
  }
}
