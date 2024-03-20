import 'package:get/get.dart';

import '../controllers/home_dark_controller.dart';

class HomeDarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeDarkController>(
      () => HomeDarkController(),
    );
  }
}
