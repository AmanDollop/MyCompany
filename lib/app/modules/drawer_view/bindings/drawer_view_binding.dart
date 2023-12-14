import 'package:get/get.dart';

import '../controllers/drawer_view_controller.dart';

class DrawerViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawerViewController>(
      () => DrawerViewController(),
    );
  }
}
